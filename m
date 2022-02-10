Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 15:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbiBJPjn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 10:39:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243693AbiBJPjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 10:39:42 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF40FA
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 07:39:43 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id c12so4010558ilm.8
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D7GM+GqUKAF1DIfoNZ7Ua9NE0gBe59nnht7Zuf81U1g=;
        b=k7PPK5rKCEMvuJXrE5mKDNy0HYl289BTEcQvBDGZNwtPJrRwPt7tJAkxebsDu1/sPf
         KOy572UE8SqYOPPXweQTXI6XW7UHH9/x72W8wYhe4sZG3pK1ZtzUfIxquiYSI1xHKYQe
         zIeEUbq9JyUbm0BeqI6HVDyvr26GOpe47qxaXDJ3WBL1Cup0HNXmypY/0HGujPwwlMyn
         tR1sEnfZPVnSjimL1Pc9xPaU9X/5vIhN6ldmh57V0Hdj4bsSXBlhT/v4nRSdJV74wbRg
         RrRXh/LmX9LiTTTAOq1CjHrrht43z2t/vjejUSLLYbuYu2PHI+QBo1lGUpxWgI1C7JGy
         7H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D7GM+GqUKAF1DIfoNZ7Ua9NE0gBe59nnht7Zuf81U1g=;
        b=kme2AxY1egMiT+Z7STMRCJRZXlRH2sk0GJtzJFND5EsZBVVg3b3Z7GaQdoUsd5QN1S
         g0LABnfs1zPAt8GFukG27mznO7b31OKd8OWcTyHCxS5DDHLVOFnqZW2lcbgNRctmB+z0
         5ifJ8UehIl0bnDBVSNlR50lYv8qTRwGbxJxkKLHU/S21FeiU4hKdnMlcu1ErtI5jp4Im
         U2n/2FeXX3HpCxEUaTMrIalfRaBhYDb627z2PUH5o+49f7OMN5dEZlzXxDwLiIhzo6Az
         pLi81v0dtTopzdHpdpNpLmvsjx4RQqKKh9e+VhT49SQvwFXff5bcG7OToACpkGkneDqy
         UNXA==
X-Gm-Message-State: AOAM532qKs+H/TSYhvdt+jO12FhIts4DzwzbayNwsIa1gLPJI7NoCCdC
        d9Pu+LYd09lbVa5ZBTlDo/cPsg==
X-Google-Smtp-Source: ABdhPJyjDh1UwbeWcK5TMRqqDXA235k/ZGoezkKzxuVJP03HulbT5qnf3LMACpPuqUJPSNMSpOYygQ==
X-Received: by 2002:a92:ca4f:: with SMTP id q15mr4388023ilo.157.1644507582796;
        Thu, 10 Feb 2022 07:39:42 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q18sm7604670ils.78.2022.02.10.07.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:39:42 -0800 (PST)
Subject: Re: [PATCH v2 2/3] block: io_uring: add READV_PI/WRITEV_PI operations
To:     "Alexander V. Buev" <a.buev@yadro.com>, linux-block@vger.kernel.org
Cc:     io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
References: <20220210130825.657520-1-a.buev@yadro.com>
 <20220210130825.657520-3-a.buev@yadro.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d505bdc-d687-a9e7-54a1-9a2e662e9707@kernel.dk>
Date:   Thu, 10 Feb 2022 08:39:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220210130825.657520-3-a.buev@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/22 6:08 AM, Alexander V. Buev wrote:
> Added new READV_PI/WRITEV_PI operations to io_uring.
> Added new pi_addr & pi_len fields to SQE struct.
> Added new pi_iter field and IOCB_USE_PI flag to kiocb struct.
> Make corresponding corrections to io uring trace event.
> 
> Signed-off-by: Alexander V. Buev <a.buev@yadro.com>
> ---
>  fs/io_uring.c                   | 209 ++++++++++++++++++++++++++++++++
>  include/linux/fs.h              |   2 +
>  include/trace/events/io_uring.h |  17 +--
>  include/uapi/linux/io_uring.h   |   6 +-
>  include/uapi/linux/uio.h        |   3 +-
>  5 files changed, 228 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 2e04f718319d..6e941040f228 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -563,6 +563,19 @@ struct io_rw {
>  	u64				len;
>  };
>  
> +struct io_rw_pi_state {
> +	struct iov_iter			iter;
> +	struct iov_iter_state		iter_state;
> +	struct iovec			fast_iov[UIO_FASTIOV_PI];
> +};
> +
> +struct io_rw_pi {
> +	struct io_rw			rw;
> +	struct iovec			*pi_iov;
> +	u32				nr_pi_segs;
> +	struct io_rw_pi_state		*s;
> +};

One immediate issue I see here is that io_rw_pi is big, and we try very
hard to keep the per-command payload to 64-bytes. This would be 88 bytes
by my count :-/

Do you need everything from io_rw? If not, I'd just make io_rw_pi
contain the bits you need and see if you can squeeze it into the
existing cacheline.

-- 
Jens Axboe

