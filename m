Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B224BC47082
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B97D61263
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 15:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhEaPs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 11:48:28 -0400
Received: from ale.deltatee.com ([204.191.154.188]:32778 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbhEaPqZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 11:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:To:cc:content-disposition;
        bh=A4d9RxRls1isE2NsARhOIk16zHvpL8uYWfXq8eEYYSQ=; b=JgDCvuEyrQ0AIw0SmSPnckXGr9
        ZV4cFu37BZzmHlsmS3ckkHDnx0DqM9fP6+/Ds7v25b+9INxWY8Yjr5prMInrp3F60G5Lz1XFJdoF9
        xnuZXqM+IzQveGn3JLfhlDbpB0qLaGG6DPsepACK230bYC0e8hrFbCZl8ZJidU0ciEQZoKyncL+B3
        /bSz4JrMvacMdyimWk1LYVyAd8JigUkV2tvi5h08HZ4Glf/0USk0/ADg4HmFYM9Ps3SAVNVGfqlV5
        SQfDVYwShhkWj4gdadUBhopKxsg9ZPfYi8n2SFpQMyN7C+JyQ+BXLGKChsVNpz42p7yvYuESYeqb0
        ccCgN2fg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lnk5k-00078L-0i; Mon, 31 May 2021 09:44:36 -0600
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@fb.com,
        linux-block@vger.kernel.org
References: <20210531044621.25514-1-yi.zhang@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2271b842-725f-03c9-33d5-fb678bf51308@deltatee.com>
Date:   Mon, 31 May 2021 09:44:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210531044621.25514-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, osandov@fb.com, yi.zhang@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests] tests/nvme/031: add the missing steps for
 loop_dev clean up
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021-05-30 10:46 p.m., Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Yup, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  tests/nvme/031 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/nvme/031 b/tests/nvme/031
> index 36263ca..7c18a64 100755
> --- a/tests/nvme/031
> +++ b/tests/nvme/031
> @@ -49,6 +49,8 @@ test() {
>  	done
>  
>  	_remove_nvmet_port "${port}"
> +	losetup -d "$loop_dev"
> +	rm "$TMPDIR/img"
>  
>  	echo "Test complete"
>  }
> 
