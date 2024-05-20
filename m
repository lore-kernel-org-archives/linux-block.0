Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89318137C42;
	Mon, 20 May 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224432; cv=none; b=S3BrjVJ7mn3gqBBo2qMHMJdyCxjkFhbuN7DuvD/BQQ5pqAIDJOIOTRl4MQAw+6s8y0+rm6o2IbSHEaDg0MTmQZFrkm9BPrXyDvVC00R1cv4ZswHLxvZ5jMrVU5F3HkeCSkFXzQzw9gHdc3RtWWOC9m8M7KLkxdDswvdh5xo4JiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224432; c=relaxed/simple;
	bh=JGYB2S6yTcgO2d865g5dJ9N3Cr0pfgIfMlJ+HBoWHqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYtdV02YBeJhOTGtsQut8Tabp9pPO7mEmxpW4emJNTgQPLCQHoso12bTQRjEKh+Nr1oorODmgTraPRlFoHF0KH//P8VsYAhlOZVH2VC9A2GSkjh8LjE4WpEsx1lGVO7v7FujvZwr73bRa9znx8j9w1B1gIktIoVG/y0tq4Vd0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ju26hfmW; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ju26hfmW"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VjkMr2SKzzlgT1M;
	Mon, 20 May 2024 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716224419; x=1718816420; bh=vKr+u0Wv7UNQpsfIGSaoT6+D
	nTw+Zuk0k0HaxCTxkh0=; b=ju26hfmWvh+lMdtwq5Ass4+hGfqL7MqGFMp7yoAC
	0WiBc8gVrWTyay2JvLCyFFnrYW3r45ENRYp8A8aqf5jrCdxLvxru+LBKFjwZ4c6u
	0QdEdK+qNILyEpnWVBldh1/FrEnLJQwldYT5Ojdm5bD3AqfN4GOsz17vYviOYAk9
	0bem7bz0Ei4XVEX5/fvF15szxxaHJHCZDvs3kdW97zmbESolR3gjy9+VaOlcmHz0
	Ur5+MlHhRi2RFsQpif4WCceE1JxCisIjw7S534NU7m3fvwhkcZqjnubwfKxKH1tl
	UhCs/8c/WZYwEr8jQLYhIQsZFAEv9buxfPC6Lw6PAHCOBw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uCTKBezyTx6O; Mon, 20 May 2024 17:00:19 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VjkMj5yN1zlgT1K;
	Mon, 20 May 2024 17:00:17 +0000 (UTC)
Message-ID: <55e8c5f0-d80b-49a8-8026-4e5a25290fa7@acm.org>
Date: Mon, 20 May 2024 10:00:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nbd: Fix signal handling
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Josef Bacik <jbacik@fb.com>, Yu Kuai <yukuai3@huawei.com>,
 Markus Pargmann <mpa@pengutronix.de>, stable@vger.kernel.org
References: <20240510202313.25209-1-bvanassche@acm.org>
 <20240510202313.25209-6-bvanassche@acm.org> <20240520124137.GA30199@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520124137.GA30199@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 05:41, Christoph Hellwig wrote:
> On Fri, May 10, 2024 at 01:23:13PM -0700, Bart Van Assche wrote:
>> Both nbd_send_cmd() and nbd_handle_cmd() return either a negative error
>> number or a positive blk_status_t value.
> 
> Eww.  Please split these into separate values instead.  There is a reason
> why blk_status_t is a separate type with sparse checks, and drivers
> really shouldn't do avoid with that for a tiny micro-optimization of
> the calling convention (if this even is one and not just the driver
> being sloppy).

How about the (untested) patch below?

Thanks,

Bart.

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 22a79a62cc4e..4ee76c39e3a5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -588,11 +588,17 @@ static inline int was_interrupted(int result)
  	return result == -ERESTARTSYS || result == -EINTR;
  }

+struct send_res {
+	int result;
+	blk_status_t status;
+};
+
  /*
   * Returns BLK_STS_RESOURCE if the caller should retry after a delay. Returns
   * -EAGAIN if the caller should requeue @cmd. Returns -EIO if sending failed.
   */
-static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
+static struct send_res nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
+				    int index)
  {
  	struct request *req = blk_mq_rq_from_pdu(cmd);
  	struct nbd_config *config = nbd->config;
@@ -614,13 +620,13 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)

  	type = req_to_nbd_cmd_type(req);
  	if (type == U32_MAX)
-		return -EIO;
+		return (struct send_res){ .result = -EIO };

  	if (rq_data_dir(req) == WRITE &&
  	    (config->flags & NBD_FLAG_READ_ONLY)) {
  		dev_err_ratelimited(disk_to_dev(nbd->disk),
  				    "Write on read-only\n");
-		return -EIO;
+		return (struct send_res){ .result = -EIO };
  	}

  	if (req->cmd_flags & REQ_FUA)
@@ -674,11 +680,11 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
  				nsock->sent = sent;
  			}
  			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return (__force int)BLK_STS_RESOURCE;
+			return (struct send_res){ .status = BLK_STS_RESOURCE };
  		}
  		dev_err_ratelimited(disk_to_dev(nbd->disk),
  			"Send control failed (result %d)\n", result);
-		return -EAGAIN;
+		return (struct send_res){ .result = -EAGAIN };
  	}
  send_pages:
  	if (type != NBD_CMD_WRITE)
@@ -715,12 +721,14 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
  					nsock->pending = req;
  					nsock->sent = sent;
  					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return (__force int)BLK_STS_RESOURCE;
+					return (struct send_res){
+						.status = BLK_STS_RESOURCE
+					};
  				}
  				dev_err(disk_to_dev(nbd->disk),
  					"Send data failed (result %d)\n",
  					result);
-				return -EAGAIN;
+				return (struct send_res){ .result = -EAGAIN };
  			}
  			/*
  			 * The completion might already have come in,
@@ -737,7 +745,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
  	trace_nbd_payload_sent(req, handle);
  	nsock->pending = NULL;
  	nsock->sent = 0;
-	return 0;
+	return (struct send_res){};
  }

  static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
@@ -1018,7 +1026,8 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
  	struct nbd_device *nbd = cmd->nbd;
  	struct nbd_config *config;
  	struct nbd_sock *nsock;
-	int ret;
+	struct send_res send_res;
+	blk_status_t ret;

  	lockdep_assert_held(&cmd->lock);

@@ -1076,14 +1085,15 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
  	 * Some failures are related to the link going down, so anything that
  	 * returns EAGAIN can be retried on a different socket.
  	 */
-	ret = nbd_send_cmd(nbd, cmd, index);
-	/*
-	 * Access to this flag is protected by cmd->lock, thus it's safe to set
-	 * the flag after nbd_send_cmd() succeed to send request to server.
-	 */
-	if (!ret)
+	send_res = nbd_send_cmd(nbd, cmd, index);
+	ret = send_res.result < 0 ? BLK_STS_IOERR : send_res.status;
+	if (ret == BLK_STS_OK) {
+		/*
+		 * cmd->lock is held. Hence, it's safe to set this flag after
+		 * nbd_send_cmd() succeeded sending the request to the server.
+		 */
  		__set_bit(NBD_CMD_INFLIGHT, &cmd->flags);
-	else if (ret == -EAGAIN) {
+	} else if (send_res.result == -EAGAIN) {
  		dev_err_ratelimited(disk_to_dev(nbd->disk),
  				    "Request send failed, requeueing\n");
  		nbd_mark_nsock_dead(nbd, nsock, 1);
@@ -1093,7 +1103,7 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
  out:
  	mutex_unlock(&nsock->tx_lock);
  	nbd_config_put(nbd);
-	return ret < 0 ? BLK_STS_IOERR : (__force blk_status_t)ret;
+	return ret;
  }

  static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,

