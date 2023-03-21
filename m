Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC3FC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 09:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCUJvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCUJvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 05:51:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A42B623
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679392254; x=1710928254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vTmk5TuFUMS/dLmfmudGcz7s69aNfPh6jndBre9n4nc=;
  b=Ij8npUW6aiSt+5MzlzvQMo/FeL/sOkezNsQ6m7/yPHONDf5j7EcrhX8H
   dAS5fAKaWyccwy4bSjNeChWNk/H8Z0pRBSEwdBJWmxS2nZfW8PJzaP7WR
   A2m9Z/9orfNO4k/3D1pwY24RxeyAyXyycFVrpuAJIlPJ0bQrskNgw/9XT
   vyWSx3Y9s54GnGc7bfXvIrU6uSKBsIU6p7encBzN55QlNoUsmhO5BipLG
   bkZc34Q/qJIWXNQ2Jfa/NeEOvqOsMjs6/TqlG9/ZcVQ4IQHd3dtl4+IZK
   S6QNXsFEEVGoiVoKtsjy3ItPjrlGcVA6VHqLwl5RWDF/i54VHwahDlw4x
   w==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="225928746"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 17:50:53 +0800
IronPort-SDR: HrMh9dX46Fcej4VWsjY5CGZioZLm0rpMcjUJxao+FTQEqBIQI/u5msyrmUhcqZseQH50G4JCEu
 Zge9lYWFWj2o8Ro8JaZO1QpmV/uOClbAGMUTzbAVc174RNk6X3knbc2p5G4II+ZGCXSPO9uPrr
 Pf3zhH7/HfGJtym1L6l04G+8iTNpbT+/VzLZ46RtzmErSjPaZ8AITcdgci0wBOWTGjAFFjDLv5
 ueAjro+XnV2J1DlAe8GeueHI2Iu/l+zSnUkP5eV/xebBKr/qIDS/ey4zHO4R2FyFIDtIqgCF6w
 eV4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2023 02:07:12 -0700
IronPort-SDR: wudMj6tQ2cU+I1vGMpEIFHbWjiQXvnIRVRywDldFhCuT5wjf+xNXGyJuun8gfrcNZulnfm//DV
 qqOr1l9W2f5ELMSIMb+nNf5viDAT/VUNvA/dU66/eoXE/J5agxf3jb3bJ+qbnACxm2ShisLrhU
 IjMP9BaEVTdkjfwSI89YOBPGeV5gVMtxCgU1xgaK+A+MT1TTNh/C3+uUnPF2aECWHOmxwSWFrw
 c4Dd5wVL1gp0XgO0bUjJ4LPMSLwnAmnPL5wwt/zbz+HYo4yudI3J1491wgVC+eBDiGa/bEfYJy
 ab8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2023 02:50:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pgn0s2Hsrz1RtVp
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 02:50:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679392252; x=1681984253; bh=vTmk5TuFUMS/dLmfmudGcz7s69aNfPh6jnd
        Bre9n4nc=; b=nQT2+9OssKrVx8dHfIkItzg8I2CvQPmvQYsKtZRu5dA83DjaOpR
        BXyaUThD4T4zez3iLTo2dMTBPACfGQQFi6NjYH4QzaVL+CstwBlnlCHQhR9Z8Guf
        rPsmglHcVMjVhMsTJIHbVCItqDT97kovLmoVuTAuu8MHSYKeRvr7PGFIutW2gN2g
        8LV6tY0fPE9b2cp7GwNVD/2D826oHAcxS2Y3Ab0goM594VndpDTAOGmBZ8XRhwjI
        JIx/BZ9sqG0TarWmI6z/usswFnSPmlVu6Ju58sJ0Zt7kCIPDLN/Kvlt7mqp8cCr7
        mleE0M7OxeQASkiEqJeog2/jb7Unt0CPVuA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IFVNxU_9waRE for <linux-block@vger.kernel.org>;
        Tue, 21 Mar 2023 02:50:52 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pgn0q1y17z1RtVm;
        Tue, 21 Mar 2023 02:50:51 -0700 (PDT)
Message-ID: <07a40b66-6785-ecb9-90ba-fb502e78639e@opensource.wdc.com>
Date:   Tue, 21 Mar 2023 18:50:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
 <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com>
 <ZBkTwV7UC5QDtRyj@ovpn-8-18.pek2.redhat.com>
 <9c74df25-aa99-afc2-4f40-3201dd67368e@opensource.wdc.com>
 <ZBlkF7zjQyahk5gv@ovpn-8-18.pek2.redhat.com>
 <cbf73fed-265f-b244-608c-bfcf5c1b6d4d@opensource.wdc.com>
 <20230321090908.GA27216@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230321090908.GA27216@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/23 18:09, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 05:51:29PM +0900, Damien Le Moal wrote:
>> Interesting. We have never seen such issue in practice with the device mappers
>> that support zoned devices. But it seems interesting to try to find a use case
>> that could trigger this. Will look into it, and if everything is fixed, it would
>> still be a good regression test for blocktest.
> 
> I think it requires a non-zoneappend bio that is large enough to
> require splitting and which goes through a remapper.

dm-crypt and dm-linear could be targets potentially affected. Will have a try.

-- 
Damien Le Moal
Western Digital Research

