Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8714F9DB
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144464; cv=none; b=lJVgV26eFCEY4SCwJwvzKgCQxYmuU17BQTz6OCz5YeNsd4pvAddMOx847GtpzcO/LkZr7sIu9213bARyii9SpVAUy9bkDLozd1ZhTzGF38GjJfvOD71PPJGSBjfxeSr1+3X8HrBIS7htI7MvjxXvzM8txafr/ljKKbQ15KDaNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144464; c=relaxed/simple;
	bh=3w7dspFyDJQSENUiAOfd6Ot2fia00VOuSacHQivyyJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKM1/k9VxbyDzsYMF4F5jf2AO/W+ohvPBFsZ7Q+1YQp5DQkuaUmGjcAaxWi3XIMixlD5mS+iggWDZgb6XjqJ85piyjhNsRCyQWyL0fENuZ6fdAqL2B03pbNAZ7RrxJ9GllJGSBC85RpUBf8poBIuSNn3twtt/0kzyYWsjOcOMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86C0368BEB; Fri, 31 May 2024 10:34:18 +0200 (CEST)
Date: Fri, 31 May 2024 10:34:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] nbd: Remove __force casts
Message-ID: <20240531083418.GA19843@lst.de>
References: <20240529213426.3165433-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529213426.3165433-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 29, 2024 at 02:34:26PM -0700, Bart Van Assche wrote:
> Make it again possible for sparse to verify that blk_status_t and Unix
> error codes are used in the proper context by making nbd_send_cmd()
> return a struct instead of an integer.
> 
> Additionally, move a misplaced comment to where it should occur.
> 
> No functionality has been changed.

Structures larger than a register lead to horrible code generation
with most ABIs.  It's also really hard to follow when all that is
needed is to move the flag setting and requeueing into nbd_send_cmd
where it kinda belongs anyway:

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ad887d614d5b3f..3fb3359850e21f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -589,10 +589,10 @@ static inline int was_interrupted(int result)
 }
 
 /*
- * Returns BLK_STS_RESOURCE if the caller should retry after a delay. Returns
- * -EAGAIN if the caller should requeue @cmd. Returns -EIO if sending failed.
+ * Returns BLK_STS_RESOURCE if the caller should retry after a delay.
+ * Returns BLK_STS_IOERR if sending failed.
  */
-static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
+static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	struct nbd_config *config = nbd->config;
@@ -614,13 +614,13 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 	type = req_to_nbd_cmd_type(req);
 	if (type == U32_MAX)
-		return -EIO;
+		return BLK_STS_IOERR;
 
 	if (rq_data_dir(req) == WRITE &&
 	    (config->flags & NBD_FLAG_READ_ONLY)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Write on read-only\n");
-		return -EIO;
+		return BLK_STS_IOERR;
 	}
 
 	if (req->cmd_flags & REQ_FUA)
@@ -674,11 +674,11 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				nsock->sent = sent;
 			}
 			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return (__force int)BLK_STS_RESOURCE;
+			return BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
-		return -EAGAIN;
+		goto requeue;
 	}
 send_pages:
 	if (type != NBD_CMD_WRITE)
@@ -715,12 +715,12 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 					nsock->pending = req;
 					nsock->sent = sent;
 					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return (__force int)BLK_STS_RESOURCE;
+					return BLK_STS_RESOURCE;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
 					result);
-				return -EAGAIN;
+				goto requeue;
 			}
 			/*
 			 * The completion might already have come in,
@@ -737,7 +737,15 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	trace_nbd_payload_sent(req, handle);
 	nsock->pending = NULL;
 	nsock->sent = 0;
-	return 0;
+	__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
+	return BLK_STS_OK;
+requeue:
+	/* retry on a different socket */
+	dev_err_ratelimited(disk_to_dev(nbd->disk),
+			    "Request send failed, requeueing\n");
+	nbd_mark_nsock_dead(nbd, nsock, 1);
+	nbd_requeue_cmd(cmd);
+	return BLK_STS_OK;
 }
 
 static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
@@ -1018,7 +1026,7 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	struct nbd_device *nbd = cmd->nbd;
 	struct nbd_config *config;
 	struct nbd_sock *nsock;
-	int ret;
+	blk_status_t ret;
 
 	lockdep_assert_held(&cmd->lock);
 
@@ -1072,28 +1080,11 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		ret = BLK_STS_OK;
 		goto out;
 	}
-	/*
-	 * Some failures are related to the link going down, so anything that
-	 * returns EAGAIN can be retried on a different socket.
-	 */
 	ret = nbd_send_cmd(nbd, cmd, index);
-	/*
-	 * Access to this flag is protected by cmd->lock, thus it's safe to set
-	 * the flag after nbd_send_cmd() succeed to send request to server.
-	 */
-	if (!ret)
-		__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
-	else if (ret == -EAGAIN) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Request send failed, requeueing\n");
-		nbd_mark_nsock_dead(nbd, nsock, 1);
-		nbd_requeue_cmd(cmd);
-		ret = BLK_STS_OK;
-	}
 out:
 	mutex_unlock(&nsock->tx_lock);
 	nbd_config_put(nbd);
-	return ret < 0 ? BLK_STS_IOERR : (__force blk_status_t)ret;
+	return ret;
 }
 
 static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
