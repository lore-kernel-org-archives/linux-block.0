Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDBEC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F202083E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 03:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="atzvYxbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDLDWi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:22:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43950 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDLDWi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 23:22:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so4409106pfd.10
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2019 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hhVbqWeYMadCsdvSaLYq23MsMS4q54LQo4uqTdoHSW8=;
        b=atzvYxbsZTlaBY0/c1qEOrTk7S+74iVUXNeorvlAgfJ0eBY75499UwaXeId3u88Lyk
         kvoD5UGAUJxn4QY5wweoBlAAKYF5AYUVLdI/Uma1dSbJvzEtSxtQZqXC8BaC+xp4QnZX
         Y+xSHbmiowQN3lsfcHpz+JnjPgglKZYsW3oI8Shfb520d81R0Ixs7gqlvuSfNfGj7nwU
         rWplo61RPXWY/VmWKkvaWrJYwV/cNlJtWDxpxdxu3iH21bbDZ8Fb6azy504vOvZ4Zvbq
         mkw3OjR9EL1eN3Yw9esqC9vv2McqSnBbiM1BIzfhhs57QZqs/Pn+hAJ9jxrp5a3o2ESE
         zG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhVbqWeYMadCsdvSaLYq23MsMS4q54LQo4uqTdoHSW8=;
        b=kwBlqKtvSvUstEiE3sdcza8zNcoPm5/KM6Y1OPOYSePW2TLXAkEU7j9LBkQ33z3ty3
         XHl9spj7Cc3q0okEF2ltsgqNQ0xyguRFHS8CAGy6a2/T7/jGPVmK4cV/3nGnNdCXuKBe
         hhx4r9jfq+KO8w3mKIXlUAjuD+aFxsV9m6mAk22p4egNwv45Wi3pLn7AilGRKo43xkoU
         rZD4jAuHkt7r32OkjYPovQuYWF0FF9asL/vAcki3cbWKG+GuEbzoAvr2e0TsFxwZHk1X
         5WmhHFvqQF16XkmUnyMRjMPczuHWU42BIzaKycVwJWPf4ZXFZ2fh08+g9BvbZdFZgDFj
         55OQ==
X-Gm-Message-State: APjAAAUO5BMJVNyj1i6MzVPIFuFcEyh+eVyGwjK3hDCGd7JTpUBFli0+
        qZqXUgyuf5yHsDnz9GFRd+EDvyx3SJr2OA==
X-Google-Smtp-Source: APXvYqz1LsHS0PzeNF9Fgkh6TwLjMDoUKpXwmjzGcv2aXDOvSOTC924q8w5z6qjmpz7rcQ1PzjGEDA==
X-Received: by 2002:a65:5cc7:: with SMTP id b7mr6677244pgt.206.1555039357205;
        Thu, 11 Apr 2019 20:22:37 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n21sm63475520pfb.42.2019.04.11.20.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 20:22:36 -0700 (PDT)
Subject: Re: [PATCH v2] block: fix the return errno for direct IO
To:     Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     miaoxie@huawei.com, zhaohongjiang@huawei.com,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20190412020916.1160-1-yanaijie@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c494aba-2f6c-a6c0-4d86-82e54dabe581@kernel.dk>
Date:   Thu, 11 Apr 2019 21:22:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412020916.1160-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/19 8:09 PM, Jason Yan wrote:
> If the last bio returned is not dio->bio, the status of the bio will
> not assigned to dio->bio if it is error. This will cause the whole IO
> status wrong.
> 
>     ksoftirqd/21-117   [021] ..s.  4017.966090:   8,0    C   N 4883648 [0]
>           <idle>-0     [018] ..s.  4017.970888:   8,0    C  WS 4924800 + 1024 [0]
>           <idle>-0     [018] ..s.  4017.970909:   8,0    D  WS 4935424 + 1024 [<idle>]
>           <idle>-0     [018] ..s.  4017.970924:   8,0    D  WS 4936448 + 321 [<idle>]
>     ksoftirqd/21-117   [021] ..s.  4017.995033:   8,0    C   R 4883648 + 336 [65475]
>     ksoftirqd/21-117   [021] d.s.  4018.001988: myprobe1: (blkdev_bio_end_io+0x0/0x168) bi_status=7
>     ksoftirqd/21-117   [021] d.s.  4018.001992: myprobe: (aio_complete_rw+0x0/0x148) x0=0xffff802f2595ad80 res=0x12a000 res2=0x0
> 
> We always have to assign bio->bi_status to dio->bio.bi_status because we
> will only check dio->bio.bi_status when we return the whole IO to
> the upper layer.

Looks good, thanks. Applide for 5.1, marked stable.

-- 
Jens Axboe

