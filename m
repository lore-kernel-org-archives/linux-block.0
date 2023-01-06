Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F0C3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 11:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAFLB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjAFLBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 06:01:20 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A97148F
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002871; x=1704538871;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ydpjo/PG9rszJfVuf0/cnxIuUewKQhm2ZsznqLALiPE=;
  b=HEeL7gMwggfF6ZV0oSFCvBSgVTDH4xkCjLFYL5YqhVJSPpwq+da5JT5X
   3O1VctMF9HfvurTeB8fK/8HjVcDCA5ct2gvqGMTXAXxOT3uhU0J4Ztue5
   MNtOnOsmaVnZh24VvHK2nAwLttF3kvIurAoKY5HxIGryhfj30iqitcQo5
   wB+gmUGcFVrik66eZmZw13qAEKculJ5opQZdd5e1ucfgT682++vISzMif
   /6Vljcv71LE/XCX5JUR/8j1Tr3lQ/hG7+B6ZX3SLma9SRCcZCNp7pg+11
   ZDadzqOahTfvqW0i6vxvP2/mjq6emCcl53/NbmMuu/QgP1nJe89dlHtqc
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="332176807"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:01:10 +0800
IronPort-SDR: K7NuFBmYf0JfagTJNURm80S5IA/OSwB0UTLH74kFmiArY1Rbu7IbZxsye09l1ey7Z0rk5XMNWX
 Rl11hzZHsgrGvpOBXglBjhBxs/xgmoufAhYhyedUXd8iMMwKY1NahzpO0TKIQhNf8C23OnqWKm
 83P/YpSY06of/QXhkXDVRrpdbc6jl0eJxPeVQ4B/AEvpCqryaHrwxWI98gvWkjmWh3bZCTPyNM
 Gdvo3mlRlqgVXhTHZyX6AKGfpO46VhISslljmR9zxgBcsz4PrjwDsFKZtwto0vDCDpYD+2qcPx
 TtI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:19:05 -0800
IronPort-SDR: jOO6YWpD1cxNBanR0vujv9T3LZ4au4nwtsKnLLG1jbzU/e3ooWlqb2DgU7LIdz7N5UZoKlPrnn
 GaVZAfcpFtO3dTXRDF6vZnUmnDfO8EmFCDYsxzymeytXYFQhBVypoHZr9CjqVYVg+aktwLCQYu
 3DivmXCiVxurj9ly+efL86QVhjtr9tMG0UQZnhVMrdro3yOydSMRt0fq5jIbguFWpJiHzR/5z2
 HfwIL8rFI++j8RP+O/qXQetV2WceFBu83Mwt6HFDDzfG9kB0Z3DaKobrcloS8Y6vMgLXgyVm7B
 UM4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:01:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL462Tfxz1Rwt8
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 03:01:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673002869; x=1675594870; bh=ydpjo/PG9rszJfVuf0/cnxIuUewKQhm2Zsz
        nqLALiPE=; b=aE9aLrbAxdk6xM3YjipPdKlKR+YBrKVCr7tYG5UMv/LfblT78Jz
        zZHTm9i+K1jvg4YO+cnrNRbVEkzQE+S6XyHCkv/8P6gt4mxRqqOjFxqi4qVbpM2k
        Cm8m2wgwu2SWy+zEQiSotsjNMFsjRXmbWLiRxY8xtgN03ctFd81o7d0F/CEuwfJG
        80b/4o0zu30Ut0aQ0x+fqiwGii+AZi9H1iGjhraY9fedjAkzGoK/wfXhYOLeL2KT
        EheQMkJXTKvT0Y/xJsz4/T5jsgFhuc80MyVBvlugUgUFdyKOSR8UjewAplW3FZyJ
        53LzhVSbb7FzBzKDvirJAcdxtEV9WO/SRwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MaYhwlnD9bAJ for <linux-block@vger.kernel.org>;
        Fri,  6 Jan 2023 03:01:09 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL436MGRz1RvTp;
        Fri,  6 Jan 2023 03:01:07 -0800 (PST)
Message-ID: <22e12d95-d00d-270d-8119-8587672976a7@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 20:01:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
 <20230106083317.93938-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/23 17:33, Pankaj Raghav wrote:
> Remove the superfluous request queue check in bdev_is_zoned() as the
> bdev_get_queue can never return NULL.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/blkdev.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 43d4e073b111..0e40b014c40b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1283,12 +1283,7 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  
>  static inline bool bdev_is_zoned(struct block_device *bdev)
>  {
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return blk_queue_is_zoned(q);
> -
> -	return false;
> +	return blk_queue_is_zoned(bdev_get_queue(bdev));
>  }
>  
>  static inline bool bdev_op_is_zoned_write(struct block_device *bdev,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

