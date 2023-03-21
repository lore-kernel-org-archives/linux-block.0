Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D22C7618D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 08:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCUI4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjCUIzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 04:55:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF032D57
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679388880; x=1710924880;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8VfO8Ry+yp9lDCQnEUoPalTBW2qaxr6bjZwLWXAyYJQ=;
  b=SqoforzlnbPyiWWgAUPqQPdFAZnuAGC4DIWg2pwI/QSTb3l+FgGVGz8P
   IrgG121VWuFTCwJEG3Z8Zyeh/PYx6bQXklcESPIngU6GCwNNbZPj3eyVn
   fZMosvg86pPLSqpAt54vnqaEJkim+Une0asVi/V/kqFtAxJizoc4Mg08c
   BPrLrxEnzFK6JxQ3IcNouthCQne83S48Pe+0y5K5GL/LNbmhLNutjkSzG
   sJz0/2O5eqkuXK0M96qNe/wnw9DgHB5GN3OFbfCEbtRchihPk33bOGDuu
   9fzZ+lgHsg8tjJ4Hqtfei6De4/xCgBrEGd1l7UExI1t2/jLAUDs3Y2hGg
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="231089183"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 16:51:33 +0800
IronPort-SDR: FHL7oSuuwSOjQnY8l6UdSQue1qViAzCllnjGvEUQifiXxNK+x4eFw/UVGsH3nlDy6kBRZdVgjd
 YgYKLyOcGlDmXO1623nAoZzw3THP+VaC6vaFveZKyHJQ36T1qOoAzfOboK8g2u3amGfzaXpTgB
 cRVA4h/0EwbKpDJzzoy5W9kiuPaGyEW4m/02rFawZny1GRYoqhDkNYtOPkwN9Y4xotyeyFwrsL
 flG46LlvZmf9jd8PLkBaJYnUIVfCxcBtmrunw2KNzMsx8uHtAczkYTvrHMGVdBWaXHQ9vik5jW
 UTM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2023 01:07:52 -0700
IronPort-SDR: Kg9ErsNU+SSqhjkZEljWn3pV188UPeL1HcwLkq+t53no+NDdIZ/q5Xx9YnhbSNvA+rinzGk7ng
 qj8mCrJVmvYtOU8JDwLNae2nDpJc2kPAU612lP5fMG/H5/4Rt8pX0K8RR1QtFJLdGo31NSFmoi
 xSCp9UcCQPpPnQVzqg/uz3LZjvF16Z1+nT1anRZQjGWvQJ7AXEgoUN3+I+ex4R27wEJUgAODFk
 Epfeb6exHFyRN8uzr4KJWDujTimEDfkAdJXplBgHWconVFgPUFZIn4DP7WnyigwzwZEO8SkzFr
 aGM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2023 01:51:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PglhN3CCyz1RtVm
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 01:51:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679388691; x=1681980692; bh=8VfO8Ry+yp9lDCQnEUoPalTBW2qaxr6bjZw
        LWXAyYJQ=; b=JvfgNszepzTlVn8uSAAZKr24REkSHGRHvEFYeSxcSgUWlRXphS4
        TdTlFv4CtFU6dQzcfyY5SHzKUzAZwhcyfU58lTmoe1bSlOBc0+JlTdB7muiKuQVg
        UzU/gDlafv4ZO2X2ovjfgMs4SktklALfGl0p6DFAg0/AN5NYoRIehE5UAYOruxGD
        QoQJJxZNnUJGLxiTldaXWNhROFmlhLWhTouAegyvrw1KelvLcrCZzjVrlKtefivo
        h/SVvRhh+ltWCltOANp0XUmEtdEQ6UD6jPJnYRHGBZJoU2yzNhe6zgaPIQtOwdWi
        M3Hhy/VssRIREtQhxH64+//UJbtEZmApPiQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Js0Oc7OffW8K for <linux-block@vger.kernel.org>;
        Tue, 21 Mar 2023 01:51:31 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PglhL31Mrz1RtVn;
        Tue, 21 Mar 2023 01:51:30 -0700 (PDT)
Message-ID: <cbf73fed-265f-b244-608c-bfcf5c1b6d4d@opensource.wdc.com>
Date:   Tue, 21 Mar 2023 17:51:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
 <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com>
 <ZBkTwV7UC5QDtRyj@ovpn-8-18.pek2.redhat.com>
 <9c74df25-aa99-afc2-4f40-3201dd67368e@opensource.wdc.com>
 <ZBlkF7zjQyahk5gv@ovpn-8-18.pek2.redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZBlkF7zjQyahk5gv@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/23 17:00, Ming Lei wrote:
>>> But I guess it is hard to maintain bio order, especially md/dm is
>>> involved.
>>
>> It is not that hard once you get rid of plugging, which we did. So far, with
>> everything we support, we are not detecting any issues and we test weekly, every rc.
> 
> I see, but I meant current->bio_list, see the following bio order issue:
> 
> https://lore.kernel.org/linux-block/1609233522-25837-1-git-send-email-dannyshih@synology.com/

Interesting. We have never seen such issue in practice with the device mappers
that support zoned devices. But it seems interesting to try to find a use case
that could trigger this. Will look into it, and if everything is fixed, it would
still be a good regression test for blocktest.


-- 
Damien Le Moal
Western Digital Research

