Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53521C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 00:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352771AbiCPAVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiCPAVd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 20:21:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D015D67B
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647390020; x=1678926020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dS9NPINETGaJreWGkFMrctZhzDiKdb7B8Uf/cLNTY44=;
  b=Yf1aMkc2S0lCgqj+UEQ4TeSd42iHn/RaYtSJTathpR4bVh6OTCS70Tj8
   yIsxGjpkRRv908ms2aaFeO4cOn7ZoMHXCSqjXcURswtYA2s+GJNZL9Xb3
   6BPMfvODfa3THfy/nv/duCLXmX4FfOm4WahHGnluJ62iWu1idCj+/ueHu
   Ot7Dur7LiZawTJT10oQBFaUSie4BUJd2XiqUtAjsSgWKnzCMoKvsfeB7F
   /U6kTFrBVQJPDtLcA9spBsCBHYCDqERjtNbTQenyZ86sSM9EqPVj0gUK+
   KLUXcSLSwnAh3WxdUk+jroGQWb8dJOSMtW2h4VUu4yyBsTREhvKQ5Jq2V
   A==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="194371120"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 08:19:26 +0800
IronPort-SDR: nRYHM+sMaRMmTVP142r9EqaKhaleBGVwhcUaAiBfm0ZbxStsZeiIIBu0+7Lvg9JoKW+QTEDxnU
 dT940v5N9Rj/9sIvIv8WQa3b8g4KsRQOeUzcGNQCbs4unmSl0z4OzP16PeoKj6KO9Xbg2bo2nW
 Z+ghklNSLNiy2mEPEYWdswkgSwYu3aB0CmNmeGoR9bYVZcdhbPx0imdDMRW8AGnEe3igG+8nGm
 TflBXUpZm2QY2dGzSjsxMHij/r1P4Nt2/t8dCAnxBUCjHeY7RzuFpOsc5Q9DUrAZ9WCqZwYn65
 k7aJ60QxuOuOO/rlmhQgqNpE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 16:50:33 -0700
IronPort-SDR: 3FF+x5V+XP5BC9CXFl91MAzQdcW9U5fD6B3iMtfg3c4kJ60t/pCqTtv9yeuZD/pu6lbkLdJaMH
 EF1qPoR+29jL2lJKE74kSlQ/pHy4zSB1e9IDSRAypGOGQs+/vGl7ueFsPFy5m46Zeomz1DADF6
 AMnQxSRjDaQhjVJEVVTKRi6+669rUMOdVtT6HsSx2v6OlOCP15rzXwPFFgNrlWxwBNDghK1WAa
 oA+ou6T0tI2/Tz4+8++jOKhxFa8v1WRuE0KI6EwYmVEmhxEq+k1hAFH2f+wzkn3BwHSCOKNZy2
 /PQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:19:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJ9rF71jXz1SVnx
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:19:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647389965; x=1649981966; bh=dS9NPINETGaJreWGkFMrctZhzDiKdb7B8Uf
        /cLNTY44=; b=Q4bLGmMMpiluWgOAnL/q8wzcww1hiXqaGiLla8cjv6VdQS6kOAV
        Geu2nFryeEJjJ9UNWpEN9lc9ZLtPQx/8vdUM4ibRs+NjX8PG5Z38PDmlgiYCacFx
        9Umh+ru44jP11ybcwzf9sB7ZsTrQasm5MgEZbUhTQyQxc97ixobgoWb0/NGk1FLj
        z0777HPbzG2SnA2Tdw+rfYw/IIYmyWhv7KtEBRW4tS6yjnpTGoMl3ruHLHHJBaNB
        EymQScqRWqXgno/mLI2S7D3VbqbSNOE1kpFXoNB2XKm/imbYQcDnFrBbgMoeYCin
        uorV8Y3++f5HrSNUHletOrDwcvAtUrmEXaw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DzTFWKhZUv1n for <linux-block@vger.kernel.org>;
        Tue, 15 Mar 2022 17:19:25 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJ9rD12Xnz1Rvlx;
        Tue, 15 Mar 2022 17:19:23 -0700 (PDT)
Message-ID: <61c81839-ac6a-32c1-97a8-f6fefb8642d7@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 09:19:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202203151944.44834.linux@zary.sk>
 <1b7a45ff-31d4-4b5a-81e2-a35e7cb0b471@kernel.dk>
 <202203152217.52855.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202203152217.52855.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 06:17, Ondrej Zary wrote:
>>> Something like this? Requires Mike's SCSI BLK_MQ_F_BLOCKING patch:
>>> https://lore.kernel.org/all/20220308003957.123312-2-michael.christie%40oracle.com/
>>>
>>> #define PATA_PARPORT_SHT(drv_name)      \
>>>         ATA_PIO_SHT(drv_name),          \
>>>         .queuecommand_blocks    = true,
>>>
>>> static void pi_connect(struct ata_port *ap)
>>> {
>>> 	struct pi_adapter *pi = ap->host->private_data;
>>>
>>> 	del_timer_sync(&pi->timer);
>>> 	if (!pi->claimed) {
>>> 		bool locked = spin_is_locked(ap->lock);

For the pi_connect() call in the ata_qc_issue() context, ap->lock is
always held, so this is not necessary.

If you have other pi_connect() calls in different contexts, we will need
to address these too. For internal commands during scan, ap->lock is
also always held.

>>> 		pi->claimed = true;
>>> 		if (locked)
>>> 			spin_unlock(ap->lock);

You need spin_unlock_irqrestore(). See the locking done in
ata_scsi_queuecmd() which is the starting point for issuing a command
through libata.

>>> 		parport_claim_or_block(pi->pardev);
>>> 		if (locked)
>>> 			spin_lock(ap->lock);
>>> 		pi->proto->connect(pi);
>>> 	}
>>> }
>>>
>>> spin_is_locked is needed because the lock is not always held. It seems
>>> to work - no more stack traces after device double registration (only
>>> ATA errors but that's expected).
>>
>> That's a very bad paradigm. What if it is locked, but the caller isn't
>> the one that locked it? Would be better to either make the locking state
>> consistent, or provide an unlocked variant (if feasible, doesn't always
>> work if it's a provided helper already in a struct of ops), or even
>> resorting to passing in locking state as a last resort.
>  
> libata locking seems to be very complex and our functions seem to be called with various lock states. I'm lost.
> 
> Might be easier to add connect() and disconnect() to struct ata_port_operations...

But you would not be able to call these within the ata_qc_issue()
context, which I think is necessary in your case. Also, these
connect/disconnect operations are not something defined by the ATA
protocol, so we should try to keep these hidden in the LLDD. It is
better I think to find a solution about the locking, if necessary using
a different qc_issue operation or using the queuecommand_blocks
attribute to have libata call the LLDD qc_issue without lock helds,
which should be OK (need to check).

Ideally, we should refine this ap->lock big lock to avoid it being held
throughout the entire submission path. I will try to have a look at this.


-- 
Damien Le Moal
Western Digital Research
