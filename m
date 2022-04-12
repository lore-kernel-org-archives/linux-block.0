Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4045EC43219
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 23:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiDLX2c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiDLX1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 19:27:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB72E7286
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649803111; x=1681339111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=34X+eZEsOTtRoq5PkOYLoT3M3mTMguL7DvU+Lx0G4KI=;
  b=AC6rp1qjU+256Zv2Yl7kVoV0YRWYmbj3zrPgHcsSf+RInTlHvBPFlfYS
   aFZsM7W6adFns6goC2nNBagb1tRageZNvQohi08MJAcHi1nU7uiBMejuZ
   8/nDKVm0KII27bn7g+Zs4JJq0fUag/5a2JF5SEV1yT7RmtgBKQzOX3q20
   8LQrr8n/pkH1K7MNLW4nBrqgmkf/0iLhwHt2L/gYHolJ/6Mhz85Da7OYX
   +bQmm0QW58oZ26cMp3BV9BxRVJ2STBy4paUEqb+IQ6ECab8JIl2FNyyGp
   LaxmO2CWbXgQWrr4y+2zGS5GHj6d5sSB+KYXK8e/Yjgx4dWhsdyD1hIqp
   g==;
X-IronPort-AV: E=Sophos;i="5.90,254,1643644800"; 
   d="scan'208";a="202626606"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 06:38:31 +0800
IronPort-SDR: NILt33MFrQV+GIBGhTS5aG/gbvYLmGOhKLLGneN/R/eCLC6FZ5R9s4ztoBXdHZayEPCp3Ekr7w
 ucTKwssuuMKvBOZZv8xBEu7YrRiL+o/+eqTGd3f7YSQT8FlC9+FEZMKrNHBaKSjn5codbfmcK0
 xCF6INBTk9gCu8O9Nyg+apE6+0jadxnYXF19cano/tjh3+tHVz3MJ/JFTRKnPFvA3VaZK0rxil
 Bsp82oFAxubKytQ7Te6ftc/ZWcFyreDnBRKixa1OjHCUN0hHlAXuLY493WbUMZ8V4bIPM2mw3L
 BFUeyeaJeHBP4QgxO459gR0i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 15:09:00 -0700
IronPort-SDR: xO2XRV4vS3T2U0mEPbV8lGXdIuCCke8JOyjhSnk5VuAqDnUo+4SNKHSdVey8UvmPauh7H1qW7c
 RR3oAiRMok5nKbFmQbZdG3C6YlDl/5VoqmX5U2wwz5ydIUD/0UY59mFR33g6Ok6ztSEantA6S4
 IZ+D9GxxxDLVCBaM14cP7eOIYHaZpKCYSJmuqgr5SafjTNQoAaPVfnKarUgb53R4QCNzqN1QjL
 yyinEgHGs4Cd84eddYfj/+Le8SR0tiB382NOe+88BWLkBFy+z+IahCwNcZszghvtHtJJhJTKKZ
 e5k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 15:38:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KdLGw4lBFz1SVnx
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 15:38:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649803111; x=1652395112; bh=34X+eZEsOTtRoq5PkOYLoT3M3mTMguL7DvU
        +Lx0G4KI=; b=jB5kPS1Z3snINIk8Latz1wk8OAyaMHtVkEL+Hvan/xO4rSMMK37
        +2KXKJgi7Y5Cchnya1DG8p+BjhKkIiqNZEc5UF/+usUSUx23m1clw7NWIvSjrOS/
        /O1HslX7c+SOqCSnam/X5hdso9CTxBDRwpHzlXDleA5aLLBMi7sNyH9nRzdbhQOl
        cyahaYZg9d/HckUZtORt+TXhXUjPcf9Y1H8dcsScEMxS5rSlkJy7ZxKzXb0JcY1H
        fZZPznvacAt4+t/aq6o43nCsWiInutdRIg7wZyxVofutoHL4126YfFMYrjNZXA7l
        jb1Kj/LYC2NHyS8P+GV9wMPia8tVf6v78dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2G4ee6li4HAi for <linux-block@vger.kernel.org>;
        Tue, 12 Apr 2022 15:38:31 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KdLGv0chFz1Rvlx;
        Tue, 12 Apr 2022 15:38:30 -0700 (PDT)
Message-ID: <c4c83c0f-a4fc-2b37-180f-ccb272085fca@opensource.wdc.com>
Date:   Wed, 13 Apr 2022 07:38:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com> <YlXmmB6IO7usz2c1@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YlXmmB6IO7usz2c1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/22 05:52, Mike Snitzer wrote:
> On Tue, Apr 12 2022 at  4:56P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
>> The current DM codes setup ->orig_bio after __map_bio() returns,
>> and not only cause kernel panic for dm zone, but also a bit ugly
>> and tricky, especially the waiting until ->orig_bio is set in
>> dm_submit_bio_remap().
>>
>> The reason is that one new bio is cloned from original FS bio to
>> represent the mapped part, which just serves io accounting.
>>
>> Now we have switched to bdev based io accounting interface, and we
>> can retrieve sectors/bio_op from both the real original bio and the
>> added fields of .sector_offset & .sectors easily, so the new cloned
>> bio isn't necessary any more.
>>
>> Not only fixes dm-zone's kernel panic, but also cleans up dm io
>> accounting & split a bit.
> 
> You're conflating quite a few things here.  DM zone really has no
> business accessing io->orig_bio (dm-zone.c can just as easily inspect
> the tio->clone, because it hasn't been remapped yet it reflects the
> io->origin_bio, so there is no need to look at io->orig_bio) -- but
> yes I clearly broke things during the 5.18 merge and it needs fixing
> ASAP.

Problem is that we need to look at the BIO op in submission AND completion
path to handle zone append requests. So looking at the clone on submission
is OK since its op is still the original one. But on the completion path,
the clone may now be a regular write emulating a zone append op. And
looking at the clone only does not allow detecting that zone append.

We could have the orig_bio op saved in dm_io to avoid completely looking
at the orig_bio for detecting zone append.

> 
> But I'm (ab)using io->orig_bio assignment to indicate to completion
> that it may proceed.  See these dm-5.19 commits to see it imposed even
> further:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19&id=311a8e6650601a79079000466db77386c5ec2abb
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19&id=56219ebb5f5c84785aa821f755d545eae41bdb1a
> 
> And then leveraged here:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19&id=4aa7a368370c2a172d5a0b8927c6332c4b6a3514
> 
> Could be all these dm-5.19 changes suck.. but I do know dm-zone.c is
> too tightly coupled to DM core.  So I'll focus on that first, fix
> 5.18, and then circle back to "what's next?".
> 
> Mike
> 


-- 
Damien Le Moal
Western Digital Research
