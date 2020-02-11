Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973AC35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 21:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77903206D7
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jJj0E9ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBKVvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:51:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40625 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBKVu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 16:50:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id z7so56758pgk.7
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f5N2DUlbv6z/GteGd/EGhO/3U8m5u/E+jnsXlDakez8=;
        b=jJj0E9ijZ6+sC99SDS/dAEQLDCqW3lG3g02rfsR8NdtjyF0QwlEOzXcRfDGLXRZTk4
         uZkklh0k5yF6W9mV7r2QFANEmtswTMADwPk1If8ZrsMEZiC8xQ2XdPlOPmPcVD+XGjoa
         jSmd8/E9rpwisrmN2kLLocaRMubaDTDaAGKHSx64kB9k7Sy+TmG41n9HbMNFAXUGS0Ur
         6tRtdtjvneygy5Y8D25FSrg53J/NTPKQylg32+i8IxWJBLceazo3gmM/HqOKGk3YGmpU
         snpDWYxbAMU/vUEHqdseqZh6p/Vnz9dckcX8jmphwgZL7jt25eO8RJoWgobv/lUQE6jG
         3ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f5N2DUlbv6z/GteGd/EGhO/3U8m5u/E+jnsXlDakez8=;
        b=Z3tS8SXKK3zo8Wpd2lShVBH3uP/3SNgUzRUtR2UrO80CogHDG56caT6meNO2OBpcoM
         0EsWgITftP2vixG/2KE9Y2Yym3TerXZV2+CoB5EMaZK0jmfxZoeKj9xSwoDZK2+lEJwR
         UZf0Ai+DmMC1bLAIP2pJvZ3caTJ9srs/7iM0BFwi1cow+zL/6KrBbItZt3rcNmOBJh1I
         VqyksfO9F2MpTbwdAW0RVXH9FFpIa6ZLSoD1uYOCojLpjAoH/nvgvUePeAnlzDJd31yy
         GfrZqNeC+GsYsIIedXWrVMAm0cB/h1p2Q+1wFgQY3lghl+fAgWtupGxuLap8uCCC3jBq
         MtwQ==
X-Gm-Message-State: APjAAAWL/EpVBEe7YEa9g62A5HYG2H8mCePGObvx1dTiTOTru5khswA2
        QkM8JS/4iiZ4L/qFJyjyN84Rmg==
X-Google-Smtp-Source: APXvYqztEKW1pNjfCbxdS8jY+0OSwbjX+iBe/EgNf951ms4uspX6jVEZ07itJ3mFQYj299xMNKUb/Q==
X-Received: by 2002:a63:5a11:: with SMTP id o17mr9146286pgb.60.1581457858499;
        Tue, 11 Feb 2020 13:50:58 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id d15sm5372630pgn.6.2020.02.11.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:50:58 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:50:57 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5 blktests] nvme: allow target subsys set cntlid min/max
Message-ID: <20200211215057.GB100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-2-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 29, 2020 at 03:29:17PM -0800, Chaitanya Kulkarni wrote:
> This patch updates helper function create_nvmet_subsystem() to handle
> newly introduced cntlid_min and cntlid_max attributes.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/rc | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 40f0413..d1fa796 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -121,11 +121,18 @@ _create_nvmet_subsystem() {
>  	local nvmet_subsystem="$1"
>  	local blkdev="$2"
>  	local uuid=$3
> +	local cntlid_min=$4
> +	local cntlid_max=$5
>  	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>  
>  	mkdir -p "${cfs_path}"
>  	echo 1 > "${cfs_path}/attr_allow_any_host"
>  	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
> +
> +	if [ $# -eq 5 ] && [ -f ${cfs_path}/attr_cntlid_min ]; then
> +		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
> +		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
> +	fi

This has several shellcheck warnings:

tests/nvme/rc:132:26: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:133:8: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:133:24: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:134:8: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:134:24: note: Double quote to prevent globbing and word splitting. [SC2086]
