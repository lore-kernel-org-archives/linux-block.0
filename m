Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F60FC3DA7A
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 03:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjAED4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 22:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjAEDzf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 22:55:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD304680A
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 19:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672890876; x=1704426876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sJcj1FWMwglYSv5QiOXtM+NnlMSpPPvz2qAzxEE634I=;
  b=Pu3AhIQRNesAlksBBmNBOWzAQrdg10LG8Y/11Lb8VVH8Jk8G/AEpdd1k
   eo3V96o17xrTKywwcTVpVRwwybg+mSlW09iWSEe2dqUcMryvaCsf129D1
   ZXUS/S+NqYsHt5Urr44kiRKySxGS+iz/WOcFuqJhCfwR0h/MPkH7xscQT
   Pma6pIJL7kAjx4o8q3ao8kU7X68Xwlq2+b2oTKUCsLs4ChnpGde6VCAuc
   0DytluTMPRFY/fP4ioWs5cHxv37POwnUP4k+iPDukfdpDEhzXEt2sIrjF
   6Tut5AnllxwhqXQu4nLWYjjH/4zpVnGEdtiKTPr4eEhwzl2cbJo1zceTY
   A==;
X-IronPort-AV: E=Sophos;i="5.96,301,1665417600"; 
   d="scan'208";a="219944752"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2023 11:54:34 +0800
IronPort-SDR: /a5WXz4qjlCC4SHYU1THHIuriMv31T2uklq2XZT+s1BPJghpqXl8/BBuLyI08nHZKA9g95cDN2
 jI1W58PGA0JpoIBJCcslAUdWGQRHTVJkukn3X9nV6pI8zPGpBj1Ijl+4YBuOwQfmnBhnuFJb3S
 oX6zVzBa4PMefUoMUhOo1uFKGv1wxBTfsGExJ7bfdOoc3v9M7poE7tH94Box/e8/zYchS+vHqx
 DiKSjIY9SAt9pVcWQ91S8LuXhFVikYCX30Wg5/RxQQ/UOV/GIHKv/XEev+31KOSQ0Uq3fQc+vH
 G/0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jan 2023 19:12:30 -0800
IronPort-SDR: +VUtI+rznv8OpEUGKJk/q9s62xz4t9Wwbd11vMkPeMii1BxNjdZHI3S23/GpA3CoebUI1vAC7n
 hHCqMz6RKVqTLGwWCqDv5JwbCtRYYzkYWueqaGKTcA2WLw2+iwA6aNxU5MF3EasJ7GwolWDcO5
 bUUNf1LPRYfWV4jN6KiZ3I7g1zHR+Xs+rIG7BfoF7iRBMHYVxgllTe6/WfM0NWBNkF8GsT4DxH
 h5M42M4GrChCptk5NUwtdQomsXpmPYuoCAgd7mEyHSwC5+T/XL26fCmLHmgk3Z0ARD+4SYRwsz
 5j4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jan 2023 19:54:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NnXfL0K2Jz1Rwt8
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 19:54:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672890873; x=1675482874; bh=sJcj1FWMwglYSv5QiOXtM+NnlMSpPPvz2qA
        zxEE634I=; b=gt8Bv3KCNKzQawY2EQHomLUUCncLi7AIKFX97AOQ4XfnZCawQne
        fZ/at8b2bJ2e/k9rzyr95kzTYdj6eeysqbTmGdirr5V76uGb4gD9PE7il5lMFpnM
        IPy5jSpc2oco18XTjrNk81+LKVo2evf1tkySo2pwOKAnsjGo9lMCVfb75WXBENA0
        FiZSW+HiB8kbZ2gsChtu0nwrHre872iJkmPdzlqUK6Bg6WUgbYwyEPqEbLa1Lhce
        h+IvyuLbehnijj+7ZSqaPRBRvOiA6ExRXelOCtqIEuDJIPa8jn0Cd2I0woX51IWT
        h0ouSlX1Pi0xJxAk90ONGJcRj7H9wGZzxGw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Kh3ZmsGiGv3Z for <linux-block@vger.kernel.org>;
        Wed,  4 Jan 2023 19:54:33 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NnXfJ1nv7z1RvLy;
        Wed,  4 Jan 2023 19:54:32 -0800 (PST)
Message-ID: <964fb51e-c37e-824f-25bd-ed46d9418a20@opensource.wdc.com>
Date:   Thu, 5 Jan 2023 12:54:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
 <Y7WL1GXmpDSSYD3/@T590>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y7WL1GXmpDSSYD3/@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/4/23 23:23, Ming Lei wrote:
> On Tue, Jan 03, 2023 at 02:19:18PM +0900, Damien Le Moal wrote:
>> From: Christoph Hellwig <hch@infradead.org>
>>
>> Check that the PREFUSH and FUA flags are only set on write bios,
>> given that the flush state machine expects that.
> 
> flush state machine is only for request based driver, but FUA is
> used by bio drivers(dm, md, ...) too, just wondering if bio drivers
> are covered for this change? If yes, can you add words in the
> commit log?

I think they are since it already was the responsibility of
dm_submit_bio() and md_submit_bio() to handle PREFLUSH and FUA.

> 
> 
> Thanks,
> Ming
> 

-- 
Damien Le Moal
Western Digital Research

