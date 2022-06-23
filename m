Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC436C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 22:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiFWWq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 18:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiFWWq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 18:46:28 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD251E64
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656024388; x=1687560388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qppZhCvuhBSnN/hSOr5MPfcsILvys9HvUKJ9bXpwxIM=;
  b=CAM3HyxQ6diALQgvFmTmdmvBtBSWZlZQSTcB+C7S9q1XuP7Q6OBMI58h
   ySc+gniCHIgGdR7whE4DpF1lPtzSnmQKLA0HYUDVzNs0IkuNmJZeVZFlG
   TFkrMptGRdohsF3gvhq7y9BH4NIPH5DcTQ/YZXVmDCMGR+C+0XGfST7nd
   +uLaPkN0tJ8wxoAbdpzi5JLbU7t2LDVraFm1c50ycofSwow/fOLh0Vfk8
   ohoAKqM9V2s0mGe+2R0gtww/dSHo6035JwAuyfLwCnHJE0dxkhxNNwMh6
   ODH4vFh0WXkP8+6+vb2XmuZPcCc+2hR+ZNYmQkP2E4U6fWrZC6USrX466
   w==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="202650038"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 06:46:26 +0800
IronPort-SDR: YjS9k5QUZ7X/a/WVyZcROxdSHHXNJyIPNhFkZ68h5buxihuLFyth2VZE23AeL6s1QsFysJ1Asm
 f+VWt//ALWZJJrQ7ggWN8jfVinpv67ccWc0re4YlYLSmj3YUsxnKAsD2vfM/VoIE0mtOEAPAUm
 inm1qDaauERbxiU9q9T2ZVrtcabJF4c5UmV6HLiZN/qNYHn5uxLdR6ZZpE42GYBgH7XqbiuxS7
 dQoJAO2Y0cYvP346m4wEniaLVBOaf3GUl+NMc06h3LKK0jcXp18pFuCbT/vG9S8FmztFK48dXu
 YsV2A5Ylpp9fRF+mNt+ZPAha
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 15:08:54 -0700
IronPort-SDR: tRPJURs3J/S6mq0yhugyI22JbmNuo3bBltuQq4gGJRx3WeAavDg/Rk9vu57ds2AM4+y7COeJCz
 eSE/suZmccM06dkD+/piyIaEvefXqCeLxDWx8AHx9PYa7T/eUVnZ4xmcWjiTKIry8T9IDKGQ2w
 dQvamTkRTgWsRpTpLgvALOZ/tZ6mcsE67uHHF7/oIeeq28xgX+cmpsNR5/On1KvAqL+uJqTuhe
 B64tf9/NKku+mCQGEZrpD+C67syohlo1yXPlXU24WOLd5oOcLAsAX7DlsZv/LyFI00llfJf5Ty
 zpY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 15:46:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTb2p48tsz1Rwnm
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 15:46:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656024386; x=1658616387; bh=qppZhCvuhBSnN/hSOr5MPfcsILvys9HvUKJ
        9bXpwxIM=; b=OVnTwd8axDIWnvibmMG+5L1qEeFD32l9f+ZzN5s717DtcbO+Yu/
        iB1uI3UzxidtMR7vwEsVg4ls9bcVfGrQdSwR1K8Qblv68YDUCjHUS7dw9N0NTQxk
        nY8LTTxba05YrFL9ttv4ndEHnzQz5u7LgPGM516djE/UwQ0GtRVbaNdDFuWuML2P
        m8wufeXQ9VPLnX1Pshfr/feXjlyKE47kvc4wyzqDi2Ejy+nHRgfnxacTWtkleQ67
        76VtXPn+IRdQ8Y8P0os6NcZLy543gisDYdD1H6bdUp2BNrl7Ep1g29MsiE2ROJ9E
        tv360ZU1lxkJaWZeRQ8Hnqohp/lKJTJc3KQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XJivNQjapvmo for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 15:46:26 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTb2n0rnNz1RtVk;
        Thu, 23 Jun 2022 15:46:24 -0700 (PDT)
Message-ID: <5df17d13-138b-f0d2-f657-3c1468fcfb33@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 07:46:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 21/51] dm/dm-zoned: Use the enum req_op type
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-22-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623180528.3595304-22-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 03:04, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for arguments
> that represent a request operation.
> 
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/md/dm-zoned-metadata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index d1ea66114d14..9341c46e44b7 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -737,7 +737,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
>  /*
>   * Read/write a metadata block.
>   */
> -static int dmz_rdwr_block(struct dmz_dev *dev, int op,
> +static int dmz_rdwr_block(struct dmz_dev *dev, enum req_op op,
>  			  sector_t block, struct page *page)
>  {
>  	struct bio *bio;

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
