Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64395C83F11
	for <linux-block@archiver.kernel.org>; Mon, 28 Aug 2023 01:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjH1Bdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Aug 2023 21:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjH1Bdi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Aug 2023 21:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517B8103
        for <linux-block@vger.kernel.org>; Sun, 27 Aug 2023 18:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693186369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KItl4Ff0QzhKXtnP/VUzR1Bzo4b9+wPDusQDcq8cvCY=;
        b=HxlUOVDfxiaMbxyHccviQPEEjlxIkGEu9b4MCju5Rk8eCsCWzwugMWjd5fm/erxR5S28zX
        Q/OW85eQNbJT/N4HMcqqevyzBQJU5bSqTLG/HKGMf/cD2wLSFQXCD4K3Oz6s4NsIX4tAvT
        QSVePOHVnth9FcAC/2zKx5+Wjz5b1FM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-hDbJDbQINyi5b4mkLKjMUw-1; Sun, 27 Aug 2023 21:32:48 -0400
X-MC-Unique: hDbJDbQINyi5b4mkLKjMUw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68a628f923dso2437697b3a.2
        for <linux-block@vger.kernel.org>; Sun, 27 Aug 2023 18:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693186366; x=1693791166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KItl4Ff0QzhKXtnP/VUzR1Bzo4b9+wPDusQDcq8cvCY=;
        b=iJQspiSbV0+fBMpb8lduwF6xcHez3Q65jPTjxR1DJAAVI6piT9y66vlfGIWHWrL+Kg
         PDXTkRMxIV/55DPFhsEzeng09oi2tI7yv6yVyNeN3rCmzA+BWinLvR/4aVTrZbYRqQO6
         BBOE1PFDoB+gK5IzEgzaMs+fcy1p6a5UQe7Z+Z/9+t5fTS0Mt5yn+nr/hgEKNicKePrC
         kX1o4qnALSLSNNi72oL6mqK3KTxfdH36yHX1t3Brwaep/xyv/CWrDCLgi6oM1juJxIEG
         S2o6iM7RN+rP22oayN8KLI6vx0GlFWHdtdohdCWz9h2RehCI3DwAvXfZQmiUyxL9Zg9V
         CfGw==
X-Gm-Message-State: AOJu0YwgyzPom8SaNP8qj8+ILfCcm+DPy2ZbEh1qj2QtcGhh1pkcCfCv
        FBTg2M4u2IEkkJ1QQ2d3291rD8XsRqz3oaw5nEQ5f8IgVkkDCR7b0unoKQxQTZIg2ets3QAg0vq
        w3cmG1JLFolRfQTVY7giR/Gw=
X-Received: by 2002:a05:6a00:1742:b0:68b:daa9:7bf2 with SMTP id j2-20020a056a00174200b0068bdaa97bf2mr14028647pfc.7.1693186365880;
        Sun, 27 Aug 2023 18:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3pY82pgSC0yiqH8pymyyx5yyCbLqL5h0m0V59ctmPtUxDt4yPvSQUC3rhvaTGr9LbZEaRag==
X-Received: by 2002:a05:6a00:1742:b0:68b:daa9:7bf2 with SMTP id j2-20020a056a00174200b0068bdaa97bf2mr14028633pfc.7.1693186365477;
        Sun, 27 Aug 2023 18:32:45 -0700 (PDT)
Received: from [10.72.112.71] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b0068991abe1desm5640065pfo.176.2023.08.27.18.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 18:32:45 -0700 (PDT)
Message-ID: <4e0c51e8-4afc-ff0c-a948-9c026bb72c32@redhat.com>
Date:   Mon, 28 Aug 2023 09:32:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 18/18] ceph: Don't use data_pages
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804131327.2574082-1-dhowells@redhat.com>
 <20230804131327.2574082-19-dhowells@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230804131327.2574082-19-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David,

Please let me know if this is ready and I will review it carefully and 
have a test for them. Haven't got a time to go through this yet.

Thanks

- Xiubo

On 8/4/23 21:13, David Howells wrote:
> ---
>   fs/ceph/addr.c                  | 16 +++++-----------
>   fs/ceph/file.c                  | 34 +++++++++++++++------------------
>   include/linux/ceph/osd_client.h |  1 +
>   net/ceph/osd_client.c           | 16 ++--------------
>   4 files changed, 23 insertions(+), 44 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 7571606cf61f..7557f4a85ef0 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -277,11 +277,6 @@ static void finish_netfs_read(struct ceph_osd_request *req)
>   		}
>   	}
>   
> -	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
> -		ceph_put_page_vector(osd_data->pages,
> -				     calc_pages_for(osd_data->offset,
> -					osd_data->length), false);
> -	}
>   	netfs_subreq_terminated(subreq, err, false);
>   	iput(req->r_inode);
>   	ceph_dec_osd_stopping_blocker(fsc->mdsc);
> @@ -2007,7 +2002,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
>   	struct ceph_osd_request *rd_req = NULL, *wr_req = NULL;
>   	struct rb_node **p, *parent;
>   	struct ceph_pool_perm *perm;
> -	struct page **pages;
> +	struct ceph_databuf *dbuf;
>   	size_t pool_ns_len;
>   	int err = 0, err2 = 0, have = 0;
>   
> @@ -2107,14 +2102,13 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
>   		goto out_unlock;
>   
>   	/* one page should be large enough for STAT data */
> -	pages = ceph_alloc_page_vector(1, GFP_KERNEL);
> -	if (IS_ERR(pages)) {
> -		err = PTR_ERR(pages);
> +	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_KERNEL);
> +	if (!dbuf) {
> +		err = -ENOMEM;
>   		goto out_unlock;
>   	}
>   
> -	osd_req_op_raw_data_in_pages(rd_req, 0, pages, PAGE_SIZE,
> -				     0, false, true);
> +	osd_req_op_raw_data_in_databuf(rd_req, 0, dbuf);
>   	ceph_osdc_start_request(&fsc->client->osdc, rd_req);
>   
>   	wr_req->r_mtime = ci->netfs.inode.i_mtime;
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5d16469a3690..caf557187ca8 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -977,6 +977,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
>   	struct ceph_client *cl = fsc->client;
>   	struct ceph_osd_client *osdc = &fsc->client->osdc;
> +	struct ceph_databuf *dbuf;
>   	ssize_t ret;
>   	u64 off = *ki_pos;
>   	u64 len = iov_iter_count(to);
> @@ -1041,16 +1042,14 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   
>   		num_pages = calc_pages_for(read_off, read_len);
>   		page_off = offset_in_page(off);
> -		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
> -		if (IS_ERR(pages)) {
> +		dbuf = ceph_databuf_alloc(num_pages, read_len, GFP_KERNEL);
> +		if (!dbuf) {
>   			ceph_osdc_put_request(req);
> -			ret = PTR_ERR(pages);
> +			ret = -ENOMEM;
>   			break;
>   		}
>   
> -		osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
> -						 offset_in_page(read_off),
> -						 false, false);
> +		osd_req_op_extent_osd_databuf(req, 0, dbuf);
>   
>   		op = &req->r_ops[0];
>   		if (sparse) {
> @@ -1137,7 +1136,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
>   				break;
>   			}
>   		}
> -		ceph_release_page_vector(pages, num_pages);
> +		ceph_databuf_release(dbuf);
>   
>   		if (ret < 0) {
>   			if (ret == -EBLOCKLISTED)
> @@ -1625,7 +1624,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   	struct ceph_client *cl = fsc->client;
>   	struct ceph_osd_client *osdc = &fsc->client->osdc;
>   	struct ceph_osd_request *req;
> -	struct page **pages;
> +	struct ceph_databuf *dbuf = NULL;
>   	u64 len;
>   	int num_pages;
>   	int written = 0;
> @@ -1691,9 +1690,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   		 * an array of pagecache pages.
>   		 */
>   		num_pages = calc_pages_for(write_pos, write_len);
> -		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
> -		if (IS_ERR(pages)) {
> -			ret = PTR_ERR(pages);
> +		dbuf = ceph_databuf_alloc(num_pages, num_pages * PAGE_SIZE, GFP_KERNEL);
> +		if (!dbuf) {
> +			ret = -ENOMEM;
>   			break;
>   		}
>   
> @@ -1722,7 +1721,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   					NULL, ci->i_truncate_seq,
>   					ci->i_truncate_size, false);
>   			if (IS_ERR(req)) {
> -				ceph_release_page_vector(pages, num_pages);
>   				ret = PTR_ERR(req);
>   				break;
>   			}
> @@ -1730,7 +1728,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   			/* Something is misaligned! */
>   			if (read_len != CEPH_FSCRYPT_BLOCK_SIZE) {
>   				ceph_osdc_put_request(req);
> -				ceph_release_page_vector(pages, num_pages);
>   				ret = -EIO;
>   				break;
>   			}
> @@ -1739,15 +1736,14 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   			op = &req->r_ops[0];
>   
>   			if (first) {
> -				osd_req_op_extent_osd_data_pages(req, 0, pages,
> -							 CEPH_FSCRYPT_BLOCK_SIZE,
> -							 offset_in_page(first_pos),
> -							 false, false);
> +				iov_iter_advance(&dbuf->iter, offset_in_page(first_pos));
> +				osd_req_op_extent_osd_databuf(req, 0, dbuf,
> +							 CEPH_FSCRYPT_BLOCK_SIZE);
> +				dbuf = NULL;
>   				/* We only expect a single extent here */
>   				ret = __ceph_alloc_sparse_ext_map(op, 1);
>   				if (ret) {
>   					ceph_osdc_put_request(req);
> -					ceph_release_page_vector(pages, num_pages);
>   					break;
>   				}
>   			}
> @@ -1766,7 +1762,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   				ret = __ceph_alloc_sparse_ext_map(op, 1);
>   				if (ret) {
>   					ceph_osdc_put_request(req);
> -					ceph_release_page_vector(pages, num_pages);
>   					break;
>   				}
>   
> @@ -1998,6 +1993,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
>   
>   	}
>   
> +	ceph_databuf_release(dbuf);
>   	if (ret != -EOLDSNAPC && written > 0) {
>   		ret = written;
>   		iocb->ki_pos = pos;
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 1a1137787487..c26a7866695a 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -110,6 +110,7 @@ struct ceph_osd_data {
>   	enum ceph_osd_data_type	type;
>   	struct ceph_databuf	*dbuf;
>   	struct iov_iter		iter;
> +	size_t			length;
>   };
>   
>   struct ceph_osd_req_op {
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 6fb78ae14f03..95daf4cdb07b 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -127,6 +127,7 @@ static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
>   {
>   	osd_data->type = CEPH_OSD_DATA_TYPE_ITER;
>   	osd_data->iter = *iter;
> +	osd_data->length = iter->count;
>   }
>   
>   /*
> @@ -239,19 +240,6 @@ void osd_req_op_cls_response_databuf(struct ceph_osd_request *osd_req,
>   }
>   EXPORT_SYMBOL(osd_req_op_cls_response_databuf);
>   
> -static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
> -{
> -	switch (osd_data->type) {
> -	case CEPH_OSD_DATA_TYPE_NONE:
> -		return 0;
> -	case CEPH_OSD_DATA_TYPE_ITER:
> -		return iov_iter_count(&osd_data->iter);
> -	default:
> -		WARN(true, "unrecognized data type %d\n", (int)osd_data->type);
> -		return 0;
> -	}
> -}
> -
>   static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
>   {
>   	ceph_osd_data_init(osd_data);
> @@ -4475,7 +4463,7 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
>   			if (data) {
>   				if (lreq->reply) {
>   					WARN_ON(data->type !=
> -							CEPH_MSG_DATA_PAGES);
> +							CEPH_MSG_DATA_DATABUF);
>   					*lreq->preply_pages = data->pages;
>   					*lreq->preply_len = data->length;
>   					data->own_pages = false;
>

