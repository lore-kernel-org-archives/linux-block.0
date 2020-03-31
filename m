Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E98CC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C8820BED
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqwdL2HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgCaPhd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:37:33 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34262 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPhd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 11:37:33 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so1086662pje.1
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AIJaewX8GfCCNVseZs66fzOQB91yKeoYu4/Ep9E7PaI=;
        b=fqwdL2HD2ynty7HmKt6Q3mkGsMmztvgSpfY+9rj4EbEx5K0xOstNlgD4sRPPsBmYMI
         jQKKxax+vROKD5bu9sAeDbd9SnI7PNjoRkgpU/kSRQuKYZd8CQBxMtAaiZNtx7e/g7sO
         iHIIBtHxmfl30ClUbVBx1Y11p+y3Z/x4wE8aieLplXMtvHRD9c20+cjdpKQCWiWRi31Q
         KTeLk20vCrEMcjKJDzFmHUdJ+R6nAIX7QapbnZBjHaJKOR046qwZhnawaCHRCOdZ1cqU
         97oNBCqUPnWr/nEaSvkYVfZJNoQPAJZj+eZtxhSqHnOTQO2xa+1prgPegntk7xFihScP
         VC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AIJaewX8GfCCNVseZs66fzOQB91yKeoYu4/Ep9E7PaI=;
        b=poZlfSiLT8MmoJgMRqp3utf2CjW9gi8k6gbKs69nQgty8qryWyR5psjdBfYummnp6h
         haKk9ay92F0Z4CzRzmKlLiBfsK43bO5++nc//FUYK8PQqgtCszwm9UgjL9TXydKFEAPx
         X+L5tvVZqZEY86kIu83Mspji/38d3e34pyzW/4oLimNQy/EYbCwLT0BJf3hqms3QR212
         X1Z4lh1kDtqqUSk0wQUs64BmzafiHZkmBFQzb/JUogPqqLasr1y9KkwDVGnwCvK05bX6
         ezlQN8lTohT8+Vp+HRBDuzi4fKTwPXb80z/Gqdyouzikm96ohtJVJfKMi06zIEU+vYfV
         yIcg==
X-Gm-Message-State: AGi0Pua58BuXmnYHAB5OHItKYPq5ZukPt281AxwXXKk5FtfvntP9Zrb1
        cintbFRhiuVzEQleUcdIIto=
X-Google-Smtp-Source: APiQypKjy8p0X5p701s5Kmd7nfiCE0gP6442ZhQ46+pvCrU9CIXn/YOOhpfWscoL/0CTifCg23RbAQ==
X-Received: by 2002:a17:90a:218e:: with SMTP id q14mr4578731pjc.37.1585669052603;
        Tue, 31 Mar 2020 08:37:32 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id x4sm12683810pfi.202.2020.03.31.08.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 08:37:32 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Joshi <joshiiitr@gmail.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
 <CA+1E3rJV2-qig0mj9s1rVZo-iScXiPqiuLF+EDszET6vtounTw@mail.gmail.com>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <b93e02fe-ce91-a2ee-2373-cc6bf8366da0@gmail.com>
Date:   Wed, 1 Apr 2020 00:37:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rJV2-qig0mj9s1rVZo-iScXiPqiuLF+EDszET6vtounTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/03/31 23:13, Joshi wrote:
> Hi Ikegami,
>
> Are you actually able to bump up the max segments with the original patch?
No as you mentioned currently it is limited by NVME_MAX_SEGS.
On the older kernel version it was not limited by the value but limited 
by USHRT_MAX.
So it was able to change the limit by the patch.

As Keith-san also mentioned currently it is limited by the 4MB and 127 
segments as you mentioned by the NVMe PCIe driver.
So I will do abandon the patch to increase max segments.

Regards,
Ikegami

