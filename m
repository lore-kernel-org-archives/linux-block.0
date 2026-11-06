Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977500;
	b=WCdnhVvhI/fmr02Gsbjp7T65GN8B4MfcYKSY+M+3ZYfIt6xMg3hBfL8Ff4+dJGAZBIPT
	 fBjWTyKUfEGDComXqSqek3DoVXIn/Q74H5OPzviKq/mpWh05StBMd0LGUaL9BsSXwQEeG
	 fDDUERM+zrXL4C5mCiZ+YgXSnRhftP8kRhNZB3zFGamRB6/kfYDXXTK43t5eaNsHTxxbk
	 pcYqfzqgI7vZz7/N0P25xf4mW0ArGH34Ojewtt/7dkYwD3UNupDJV2irMHVBeliIhVsTa
	 9vSeqySI5ItIjJh16FhzOng8wDv7sgiTXlC46UWa2tIvhp/wqmF6uP73C28QYqk0OeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pLGPVVC1dvkEe1meLCbPvsKgkQ4CMYaqv2RlyAp9Axk=;
	b=qq1+lws0StbGWGWgGRaG42v4UtHIiVo3dfBDyflAJOHv/kXfXVIooyP7lYMoyr3WNegx
	 BgJ/zCdTAb2uUWMD1l1Qyp/T9DajMFOhqh1mJTTnUueyk1vv4oo36LK8SdOs5FYWRYm5A
	 hNyMVGKJ/SpS+VC+7f4wLNaNkJjhnmlCR2Fsz5rnBAHYQ3HN5LXruuVk6+LDm4u5y6otS
	 NLFeK31Gh0Wlqc3+xySa2QoLN+MTlFfhm29vrv9I1jWWK3x4Mfhl0wryYXqMpIct0uOyd
	 PDPTGmdmDtRbYypr9uCeL7JUoDR0RMQGcekp493zsKm2JRqJpSHl20wP2xHAxxKyVCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqM3H9x4;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D6606A326
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 15:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqM3H9x4
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-716ea2598eeso417328eaf.0
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 07:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977498; x=1794582298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLGPVVC1dvkEe1meLCbPvsKgkQ4CMYaqv2RlyAp9Axk=;
        b=sqM3H9x4opQsS0wUdVh6/HUTWeKevAK0nr7RWm0o9vM3fyDUuXtQ3sTRbB2UjERVzf
         1oFhKwSHyBj3dexkGO/eNBDX3CqW07tAQUv4BjZREyTle+EcyOkaLVXOcaW3PNtumZIV
         9+v2z0djODoLlP+xVBfaX3SZvno3SRMzIg6bTqkG8XN5cXRUpd6T9sg9M/AYpvUS0jgd
         WchohnvK/fPHkd6rjDESlkcZlnA0Kh2Rj+kKyxbsWeAkNAJoxzgWkgWW6P4s11vidbrA
         O1gZ/UpJdxxKiSs7RTI000UoShFCmiz4HuTUm+YCY2vtV2dRfi8XFtRGfFLPi2w4nIAo
         zEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977498; x=1794582298;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLGPVVC1dvkEe1meLCbPvsKgkQ4CMYaqv2RlyAp9Axk=;
        b=tYqXfDHd3/jIwHbxGEAXckyKcNcEjOwQp0hU6DmN5Ff17e9Mg30nmZHLWkCqDzm8C2
         hTr6eaEz7Db9qruoFxv3yeBfTZethqxCLNexV5Svr6VnRaymMGZeeWa27Y+HBWvFBuKZ
         SdL/oM3zOdk60uyqhw0OuuHSWsFKTMZ8tEezSntqBoMvotyhbaR5qNkX/G7t1hAHq1Nl
         ttNYgifkLe6Mb5RP8o3G6NBSREleHxud6fkMDjhe/C4AE7KcR6o1FxmuMwCak3jbNaYT
         UeawmqWXvTLxpfwW8bcUaIYvvPbaHyj+HnDuvAmfk9djthxIOqwasjIw4N77loSwgdUp
         TUdA==
X-Forwarded-Encrypted: i=1; AKwUvBzGJe143XFO/OoyfjdG3IVBxvv90jtJRkB/HzU+aOgeQEBcyq0IJuUZLLGKhCPoIHe7dLIPI0FKZ4VM9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/LGZoKoWTOSKnLzMdIyUH9bA1a4yVsreg+CKzCt29tLXvvsu4N
	x80PGCYABU8d1/Gg5m7mwpTLyxAHqiFO13/D1GpowsSGRbWohJvv2OBfJJBD5NpXLFU=
X-Gm-Gg: AYBFou0B+N8njm2zWnS3QMpsMonsKyqTBgNw+WtEdoOPvtCN0yMeD8zfFx7y3Ved4jd
	tDlrmIByrJPDRJGKkEMpT1SlwKiJIrmDduhRK24Lv2v+lAIhaHXjaJ6pj/fjb7KwYD5il6buH9g
	vBT0BDBPv4afH7SHf4AX4nbfAyHEUJ0PSf9JBvtWE50czz2Z18+YolMN1At7bTWBleuJKGmWwug
	8eL6DIlXYZ295SKyaP3U0M3gNObAF+T1h+KeA/mcKgU0bnxRrYUDXc0PyiFPA1Mr+49c/JCDFls
	kbKkzNAUMC3wA+VzXO/aClTHJgMvF0W7b2bEGO3UAWsN0nEb+NaxoeXOIza6F5SLWiGt9d5VXqJ
	Z8xR8VXp+l5wt2OjK+sA4zmxQ/76uCtGV15S6cjyXobhLBDFe9lky545utX6Od4iZq6q4gV+7Gk
	vi9UnpGjXWaDGX9KE0D6D8rQrOpQWC31VbpNnblByoyauhUsmqpKG5eHxST3cwGq1chiG9FI3HB
	6Dg1Ia13/2ih/09yj5B7tZOrIKqtOxv9PdO+ZCrmTxmfa4IbKfwReLPLxyA/p3cw8KGu+EQgWUf
	iiBIw+iEghAFKIVThzhu33mph9nLE96wuY6H2VsK4oGDrGpC/X5dOcNGNeQF5uJABXUiqJR/jrJ
	0Z2ADCVpznXP+eKzRSyAtd/Uzqg/1BnbJWIzKm63NrhxEHMo3aFZw
X-Received: by 2002:a05:6820:c30b:b0:716:caab:533f with SMTP id 006d021491bc7-716e790efc2mr1183046eaf.23.1793977498432;
        Fri, 06 Nov 2026 07:04:58 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad97887024sm2384074fac.5.2026.11.06.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:04:57 -0800 (PST)
Date: Fri, 6 Nov 2026 09:04:48 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: optimize ublk_queue_cmd_list() for length-1 lists
Message-ID: <au3skE6GvVt6SNx3@fedora-laptop>
References: <20261105021351.2295547-1-csander@purestorage.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105021351.2295547-1-csander@purestorage.com>

On Wed, Nov 04, 2026 at 07:13:49PM -0700, Caleb Sander Mateos wrote:
> For a request list of length 1, ublk_cmd_list_tw_cb() is more expensive
> than ublk_cmd_tw_cb(). It loads rq_next, which is in a separate cache
> line from the other struct request fields accessed in the dispatch path.
> And it dereferences mq_hctx->driver_data to get the struct ublk_queue *,
> whereas ublk_cmd_tw_cb() gets it from struct ublk_uring_cmd_pdu
> alongside the request pointer. On the submission, ublk_queue_cmd_list()
> can cheaply check whether the request list just assembled has length 1.
> So pass ublk_cmd_tw_cb as the io_uring task work callback if the list
> has a single request and ublk_cmd_list_tw_cb if it contains multiple.
> 
> Collapse the req/req_list union in ublk_uring_cmd_pdu into a single
> field so ublk_queue_cmd_list() can store the head request to it in
> either case.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3d322fa1bc83..c397e354a7d6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -117,21 +117,18 @@ struct ublk_batch_fetch_cmd {
>  	unsigned short buf_group;
>  };
>  
>  struct ublk_uring_cmd_pdu {
>  	/*
> -	 * Store requests in same batch temporarily for queuing them to
> -	 * daemon context.
> +	 * For ublk_cmd_list_tw_cb(), a list of batched requests queued to
> +	 * daemon context. For ublk_cmd_tw_cb(), a single request.
>  	 *
>  	 * It should have been stored to request payload, but we do want
>  	 * to avoid extra pre-allocation, and uring_cmd payload is always
>  	 * free for us
>  	 */
> -	union {
> -		struct request *req;
> -		struct request *req_list;
> -	};
> +	struct request *req;
>  
>  	/*
>  	 * The following two are valid in this cmd whole lifetime, and
>  	 * setup in ublk uring_cmd handler
>  	 */
> @@ -2104,11 +2101,11 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
>  
>  static void ublk_cmd_list_tw_cb(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
>  	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> -	struct request *rq = pdu->req_list;
> +	struct request *rq = pdu->req;
>  	struct request *next;
>  
>  	do {
>  		next = rq->rq_next;
>  		rq->rq_next = NULL;
> @@ -2119,14 +2116,16 @@ static void ublk_cmd_list_tw_cb(struct io_tw_req tw_req, io_tw_token_t tw)
>  
>  static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
>  {
>  	struct io_uring_cmd *cmd = io->cmd;
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> +	io_req_tw_func_t tw_cb;
>  
> -	pdu->req_list = rq_list_peek(l);
> +	tw_cb = l->head == l->tail ? ublk_cmd_tw_cb : ublk_cmd_list_tw_cb;
> +	pdu->req = rq_list_peek(l);

Both callers guarantee the list is non-empty, so this is fine. It
would be a bit nicer as a rq_list_is_singular() helper in blk-mq.h
rather than open-coding rq_list internals in the driver, but not a
blocker, anyway:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
