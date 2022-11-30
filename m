Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB8C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 09:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiK3JzV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiK3JzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 04:55:20 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6912E684
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 01:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669802117; x=1701338117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PfmM6a5gkT8LDyP+3VBEQwikCCOkyxOtDnm2zOUOXHY=;
  b=n6xvAyClAuY3VtKb3I4Dtegb7527oxYLiMsYSDCm88qteKKIv4F4cpHG
   qmI18Nyl1M2K/sR0Jzquu3YR2VUqXl2lyrRZDw6aSJGMz2wOof03aZfOy
   xGH6GmJ8bJSSjwDWBJRMdG7NwxyUPy18qphG6lvG/cFQoTww7AjI7Tm+P
   xr9j/D4ipnGpJFlU12QRdX9jDkzXXp2oBWI2VzVTO2N0Dkogm251ITrh6
   j/r+T3n2rkM2sIFUQ1hI31wQ66phdVahI6yQeGAzkweH0gF+cvS2t9rvJ
   ymLLd1KfMf+d024Oj6Ru3lNqb9u8K5A3d/1JxCbPGXTyRKzBU4iXjaGZA
   A==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="329640821"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 17:55:17 +0800
IronPort-SDR: WPMwauaWJiv+Wm2fqtiKGkPMH7DFlwOy1839XtTXIylru2jxIMumsQcx6F//MqbU41WBhztugs
 /WS9UDBYSF9onNwu514/BP95IYbgvFgNgXCntrsWRMaBOXbEbdEdPlEr4Gb9Ycu0SAO8hECIul
 O1TvKQHlc6cJJVkS+4nHmG4PuZRu8LzoEzlqs3Uu97rufuJNuBRbNykjGfM84h2fa7Qs3DquIp
 FRWC/LrLcUDpT9KR7LvpgLq8nErhh/G7uqqLnshktrCzIGFfkSC4KrvfsZ47kt6slVDBmm8OSB
 DEM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 01:13:56 -0800
IronPort-SDR: 4XduQR1/NHOSFfdDCN5Lh0IdlLR0awhE31idl2PT0tfeeoUwIsJf4ATM0wzXA23iVh9Y4vSCqW
 hEGtwwc3UEvpR8O8lIuTc0M62JnkrQYzcTr0gJjGB0Xe79ruZkbmizAIvwXozKeOOD2AGiMEfv
 XUcErii4rXd+ZYcf84cATRQuYyDKUp+LbXFlXrg8TQzHP4ooFo2UGNNNEsR14beddhfS4/cy0V
 sx67g+skJivT5Sg+CwyGWeBFppZqxT9sYfMezjOM3rTXu5h+ROBja53907Cbnb9UhlQcVmY70w
 QLM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 01:55:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMZM908hDz1RvTr
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 01:55:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669802108; x=1672394109; bh=PfmM6a5gkT8LDyP+3VBEQwikCCOkyxOtDnm
        2zOUOXHY=; b=WO70GxcfoJkaidzfqKTpf6XdrSJR92gGBcqtVjjWImgnNKJFA3C
        1qQ9Pac2+l9iEMRSkNYcb3YtQr2CmP64cVFOL1AzWKkAattcadn9VRgdDzzu3sYw
        a+b7n0DmPMTxgPx0L+moOK5KuWtWefFwiMikDVPA+Rm9ccaiG+TK/Gt1Nscesz8s
        zfjKvyMMqoH4tmasBu11mn7xan6xxRBhghlPHoQ+BCXda+WI3SAj0t1z+JF5L3w+
        lOZ1r/wbs/0FcsfgTQXKDer3VH0RggQmo59VaOB/EpQKyYPqFr39FgByPQi74sIu
        yFIjzvJNf44Tp2JxaVnhNqH5C0oypUoGLzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B0pmCs-csMEH for <linux-block@vger.kernel.org>;
        Wed, 30 Nov 2022 01:55:08 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMZLx09szz1RvLy;
        Wed, 30 Nov 2022 01:55:04 -0800 (PST)
Message-ID: <1ef5747a-9469-4365-ffc9-05daa6f69288@opensource.wdc.com>
Date:   Wed, 30 Nov 2022 18:55:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        naohiro.aota@wdc.com, jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
 <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
 <20221129122232.GC16802@test-zns>
 <b22652ee-9cca-a5b1-e9f1-862ed8f0354d@opensource.wdc.com>
 <20221130041728.GB17533@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221130041728.GB17533@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/22 13:17, Nitesh Shetty wrote:
> On Wed, Nov 30, 2022 at 08:45:55AM +0900, Damien Le Moal wrote:
>> On 11/29/22 21:22, Nitesh Shetty wrote:
>>> Acked. I do see a gap in current zonefs cfr implementation. I will drop this
>>
>> cfr ?
>>
> 
> yes, will drop zonefs cfr for next version.

I meant: I do not understand "cfr". I now realize that it probably means
copy-file-range ? Please be clear and do not use abbreviations.

-- 
Damien Le Moal
Western Digital Research

