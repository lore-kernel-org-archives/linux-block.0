Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF27C4332F
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 04:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiKREfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiKREfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 23:35:36 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76BE92B7B
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 20:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668746134; x=1700282134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mk3qS3WkjpfUFwGa8jTX0AKAe1jB51jDXf06G4i8CQE=;
  b=JyvSSNBRaEZOIh2WdbAKPxWRZ0jj8FPTgNsvqJ2wBS7q1EIz+4fDSfoG
   seKHSBCicxFeTClTrdQMAlVhlw/SGRF+vMcTv70Lduh9/2d74ZbnSvoGH
   RFkjz15FCX6rgaSwzLHYM5yaSKf6QTtZMiuKadkA0dSRq2KORyr/wAhAg
   8xT4/HYfSZ57voLWgYKXMSgn3qHHGdRfUAOK6UChWp1ZSroKdmymRKK+N
   HN2ArEoRkSTe229NH2maerpzL3OMKxQrEm42RDt/2nHarXIMeaWcDXDbV
   Rk0ns+tI6XkusPxSDgg5pAVIIxK5/z8Vc3tv0XST3lQO30Rk+cXHrwVog
   g==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665417600"; 
   d="scan'208";a="320923517"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 12:35:33 +0800
IronPort-SDR: ntwBjqm5mUz4vXHpVGkC5OyYMChVIDYQLGqJd2t6qb6f4QdcZgdSLUK1Wfxgj/Y609qF4GYPKo
 KHbB/F/Bv276VCaYeAw5Fqw8HpZMN0P4NHxaVVubOe/tjm5u+//wWEIDOd04+LhCIhrtdqVeq9
 GZZM3LY4jS/ggpymLxBRDxi78b6qqZhQkbBoDhqSmEXFWJ1+wttthbeQ2XvOMrWn2+sBx1qOCz
 yZ5tSMbd3Phj43LpaZfJxff6QerwhIqQ9tKsBbX1Db9wPZDtrFcBnJW38JHe0bhUBbCwXUPCEV
 7IM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 19:54:27 -0800
IronPort-SDR: msH22UmC/eplxlWk9nUQVex/v8SJnXw81TxwAGANZm9X+Obbvs9yPoURvLU3XPoPDknlAzxIh2
 iVplx9nn38/TNGaoAcitKU02hCT/IXT95XQBVzODX6OP4zQs2T8VLF6prM0K9GI41ja3B2Yaau
 d3g7BC66dlD1yVY7LiPxWwPP0lLhKXvTQBFYGDmTGVuSlcf+CjzuulPu0o80/1fWczxtVDOodI
 KpgPfYYApL+nhBL2KSTMcioXCoNEcTtbRJqzxkfyBmLCPivMf72gNifBcbuvOJCoN8yd5nZdO/
 c84=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 20:35:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4ND3qn2M3qz1RvTr
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 20:35:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668746132; x=1671338133; bh=Mk3qS3WkjpfUFwGa8jTX0AKAe1jB51jDXf0
        6G4i8CQE=; b=L6osM2jed3xHLDaJt9DxNd5EhwqKWZ+a2JAFsCZ1umY39FI2Mzo
        kM/xAWoNX27FgU2wZvNdtj/T9AFq8vPeJLN7pkCXgFO2lWqz8gYo9btorZcuqBrb
        M1R1y9ucqTNwczizaBRHBMbML5H9x8dPTJ/lLacpbEYJVt0eWhCK5h1WKrXJm1wn
        5Sgi5BFP103I/+e81PeJqcwN4o4Q3nRTSwXxzPxTxGIxmzW08Rho0iwMd6qQJekE
        P1rILpYBcEFpT3qmzBBwSilEsI+dz8oTAjpdeJy44KaXLszvZ1U8VH5SGNq2RDJ/
        N7koJKucd4ejG3mWfchfiqu70FxSMZ5tkdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ol9aw908Y7pm for <linux-block@vger.kernel.org>;
        Thu, 17 Nov 2022 20:35:32 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4ND3ql58X8z1RvLy;
        Thu, 17 Nov 2022 20:35:31 -0800 (PST)
Message-ID: <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
Date:   Fri, 18 Nov 2022 13:35:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Reordering of ublk IO requests
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <87sfii99e7.fsf@wdc.com> <Y3WZ41tKFZHkTSHL@T590>
 <87o7t67zzv.fsf@wdc.com> <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590> <87fseh92aa.fsf@wdc.com> <Y3cGM0es14vj3n3N@T590>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y3cGM0es14vj3n3N@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/22 13:12, Ming Lei wrote:
[...]
>>> You can only assign it to zoned write request, but you still have to check
>>> the sequence inside each zone, right? Then why not just check LBAs in
>>> each zone simply?
>>
>> We would need to know the zone map, which is not otherwise required.
>> Then we would need to track the write pointer for each open zone for
>> each queue, so that we can stall writes that are not issued at the write
>> pointer. This is in effect all zones, because we cannot track when zones
>> are implicitly closed. Then, if different queues are issuing writes to
> 
> Can you explain "implicitly closed" state a bit?
> 
> From https://zonedstorage.io/docs/introduction/zoned-storage, only the
> following words are mentioned about closed state:
> 
> 	```Conversely, implicitly or explicitly opened zoned can be transitioned to the
> 	closed state using the CLOSE ZONE command.```

When a write is issued to an empty or closed zone, the drive will
automatically transition the zone into the implicit open state. This is
called implicit open because the host did not (explicitly) issue an open
zone command.

When there are too many implicitly open zones, the drive may choose to
close one of the implicitly opened zone to implicitly open the zone that
is a target for a write command.

Simple in a nutshell. This is done so that the drive can work with a
limited set of resources needed to handle open zones, that is, zones that
are being written. There are some more nasty details to all this with
limits on the number of open zones and active zones that a zoned drive may
have.

> 
> zone info can be cached in the mapping(hash table)(zone sector is the key, and zone
> info is the value), which can be implemented as one LRU style. If any zone
> info isn't hit in the mapping table, ioctl(BLKREPORTZONE) can be called for
> obtaining the zone info.
> 
>> the same zone, we need to sync across queues. Userspace may have
>> synchronization in place to issue writes with multiple threads while
>> still hitting the write pointer.
> 
> You can trust mq-dealine, which guaranteed that write IO is sent to ->queue_rq()
> in order, no matter MQ or SQ.
> 
> Yes, it could be issue from multiple queues for ublksrv, which doesn't sync
> among multiple queues.
> 
> But per-zone re-order still can solve the issue, just need one lock
> for each zone to cover the MQ re-order.

That lock is already there and using it, mq-deadline will never dispatch
more than one write per zone at any time. This is to avoid write
reordering. So multi queue or not, for any zone, there is no possibility
of having writes reordered.

-- 
Damien Le Moal
Western Digital Research

