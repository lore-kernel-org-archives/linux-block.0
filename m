Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C8CA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F4221835
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 14:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x3fu0CfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKAOr6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:47:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42544 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfKAOr6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 10:47:58 -0400
Received: by mail-io1-f67.google.com with SMTP id k1so11150326iom.9
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BeIbdkmxPYwA4T13HKBZg++DpXYrgkFvAhhSTcv15h0=;
        b=x3fu0CfLHsE/1IOqYXE9YzRQkDhk39+9EECOmh09S8L0I3z+j0NrFMWCjly4vOQpk3
         pcCK4u57bfyM7322Es9JyCAF7AnPtaYxB4CtUwOy58iXGK3kIinLJ2h0PGOlIYzt8v/r
         oMlkb8SVWQtoQiqnY0uXP4riE0mfq3jsJwjucy0iucf8ykvieX6fn5vw01lk7WqI2ous
         U6wFAaad92/uLe/9EvAt55Uf2AuHhF9Ujj/S8gzKrwhauBVH/1/6w9C8CbHP3tMJmjI0
         m1SS50aPzyulvJOqYiNKOYDX/SKVASra4B5kGCIoUbsoX9bvBJ/KOBAQP1zJNrS7e4UC
         /VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BeIbdkmxPYwA4T13HKBZg++DpXYrgkFvAhhSTcv15h0=;
        b=ifFhGvSemi8hxeeWz+XrYj0Y8Oiu4gGxlJvqRd0hNNzz3dLArY7vQnNrMpIn2P8WYd
         fRdYTqw5q1I/BMXDSNUyNjxf6MRsUpg1VYL8E6CtsMoKIlNVJWA2D3KUCh9nublVQoD9
         eHatWhosvsmsE6uOlbo66h6a/XWh+eP02ZM/t6fNTwDt/7Cc9eYaRb+RaOKuZ5Jlvm0W
         vSfZfTBYVdAwgtPe8DHPcw96F96ssELToEKzsgHEsw9xWCe193RRoF75WLLZNcw0XUYm
         sfCc2jdWzPXXG0NaW0k/E5ES8gr2K3IO2kam7lQqCVhR1ypN3kQMg1hny4oo25hONe73
         bwdg==
X-Gm-Message-State: APjAAAV9DBDBAzXOma+wALKwx/nz85exLtmDCPnzw0k3aeasZyzUi0ia
        QE46dI6m/NSy1TxXxL6YtYgOug==
X-Google-Smtp-Source: APXvYqyhMKwJs1xFN3kgU68EyLOVs67imGeYdPZNcFQXrotVCpmsKpZr0o5GBDMpBcdir0kduiwLlw==
X-Received: by 2002:a02:998a:: with SMTP id a10mr5143185jal.99.1572619677780;
        Fri, 01 Nov 2019 07:47:57 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v18sm250452ilg.43.2019.11.01.07.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 07:47:56 -0700 (PDT)
Subject: Re: [PATCH V3] block: optimize for small block size IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-bcache@vger.kernel.org
References: <20191029105125.12928-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f98f8fa3-8dc6-2316-200c-c3c4a920940e@kernel.dk>
Date:   Fri, 1 Nov 2019 08:47:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029105125.12928-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/19 4:51 AM, Ming Lei wrote:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 48e6725b32ee..737bbec9e153 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -309,6 +309,10 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>   				nr_segs);
>   		break;
>   	default:
> +		if (!bio_flagged(*bio, BIO_MULTI_PAGE)) {
> +			*nr_segs = 1;
> +			return;
> +		}
>   		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
>   		break;
>   	}

Can we just make that:

  	default:
		if (!bio_flagged(*bio, BIO_MULTI_PAGE)) {
			*nr_segs = 1;
			split = NULL;
		} else {
  			split = blk_bio_segment_split(q, *bio, &q->bio_split,
							nr_segs);
		}
  		break;

Otherwise this looks fine to me, and the win is palatable.

-- 
Jens Axboe

