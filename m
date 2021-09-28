Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A660CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A75E611BD
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 05:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhI1Fxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:53:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20559 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Fxj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 01:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632808320; x=1664344320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4YmBsY/+C8sqNMhP9//gqzstLq3xe/CrHUS0BLhu0LE=;
  b=X3nFBPEnxt3vRZtd6omBi1W6qjLZ8lBWGrqdHdA9BXQ+pt7APR2Nhvsg
   6nZkUpFXHJUQB01m0r2IFz3u2hMoVzotL513j9/W/Gx0nBPsYXlB/MM+2
   7O94Q2BBBFpDnNhHYnCPb13HSqed0eNMshulqby0JzQEkys35AGDBCxXe
   1g9njaBpig/t37LldAg96hn0DpirzzElH6cI558/UBsjWrvZKEarMTAm8
   4EzGiuPQhFkmlGBGE7Ai5bfmjuQ9JIQosam3JqpqwJaNoU1TbqOlLTC94
   HoytdFcCccC6nZ/nNPGq1ZYICUrxYOLF5clMetT9Y1HueT6D5lxQlSC/c
   w==;
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="181159167"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2021 13:52:00 +0800
IronPort-SDR: qXyOQlGFFq5yS1XFkgTKSxMUzwInKd2MY4fvDUoAwv1lC+xlhVhb93OTwf/4QJftxHHf78mDlU
 09ksU5aHDszEtitGdeKt/KboO+nz4p0C1rMRd5mz0UdLd0EFyaSD1pzgYzhKavua5GzyxdnD3r
 GlqQBq1zuGlevfzG4A5nVxQYXK2jtce3UVZb0tdU4UvzsC0xXJElqf8Bb2t4lcAq12iDRNvBRa
 3EtRVu5OmwMEFoMYyLOeSHN0GnSTo5/ZsZg6nR/nuijlz6QkIS1+woibevnmnyv0M8Fa1+HGDR
 NgyzjabGPJTBtSDJz5BQroAN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 22:28:06 -0700
IronPort-SDR: d/u07tLXd8bx7Upkz2pSNGdZGQf6OQWn/YLSAfr8Z6/HsR8Sk2yOeZjoLNnVhm9QymcwZgMacg
 b/gq7nS02pMr0hhKQC6nMu/uQUEqim1KljDvmwjaVyXys0u3ER/SSRWUx4uOZp6vFWF5zPTFAH
 Mcr3gjWi198bxT1li/AH6E5shMO2AVj5TK5M5Fe+nrT7hGtdlAVElxf5Xd4xZR5Gejzb3tKF1J
 jH761eQGPxs2c2K+R6hiAYYZuzIGIz6yHVcs6q8QtE80Z6jw0tzHOS7mkRtaVsDEy9F7rKVNdD
 vj4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 22:52:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HJTD03hZrz1Rvlg
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 22:52:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632808320; x=1635400321; bh=4YmBsY/+C8sqNMhP9//gqzstLq3xe/CrHUS
        0BLhu0LE=; b=ZgbjhSWr66ILNXFkdGvp7wzEfzfzpeUzPO0xbXpU8GrkwE9pAGg
        ELhH4YovYxIblNza9W2sKsYsnmb+qukpcKunLVrI59KyYSZvfTYpMcaSmTbzQWJk
        Cd80NOnLnJKCKPgpZG+30ZVdW9uRLkwZYEuXiGmmhIByAaksic/UhYefGcV4sYEH
        wVtj/w+mwz+vzKqPNHzO7gklKxIZoBuzkJhgsddlPt+CFK02IZ+ckqTtMIXKc40d
        80E9GauV9ioaKqWCNygleK43B5pll7MTwq1Kje/nSVTiy7C0WDxjaZl7+QlzN2BA
        aIfjXMIJr6mJwg3DcoFClnJl3OlstMf/L3g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id adfpJVnl7aPX for <linux-block@vger.kernel.org>;
        Mon, 27 Sep 2021 22:52:00 -0700 (PDT)
Received: from [10.225.54.48] (jpf009086.ad.shared [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HJTCz50Ssz1RvTg;
        Mon, 27 Sep 2021 22:51:59 -0700 (PDT)
Message-ID: <dc4c388a-4e6d-86fc-d7ef-8d6ff6275a1b@opensource.wdc.com>
Date:   Tue, 28 Sep 2021 14:51:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] block: print the current process in handle_bad_sector
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20210928052755.113016-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20210928052755.113016-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/28 14:27, Christoph Hellwig wrote:
> Make the bad sector information a little more useful by printing
> current->comm to identify the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 5454db2fa263b..4c2a3db4bd336 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -636,8 +636,9 @@ static void handle_bad_sector(struct bio *bio, sector_t maxsector)
>  {
>  	char b[BDEVNAME_SIZE];
>  
> -	pr_info_ratelimited("attempt to access beyond end of device\n"
> +	pr_info_ratelimited("%s: attempt to access beyond end of device\n"
>  			    "%s: rw=%d, want=%llu, limit=%llu\n",
> +			    current->comm,
>  			    bio_devname(bio, b), bio->bi_opf,
>  			    bio_end_sector(bio), maxsector);
>  }

Looks good. A stack dump, while noisier, would be even more useful :)

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research
