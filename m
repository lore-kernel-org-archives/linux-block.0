Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34628 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdHTGiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2017 02:38:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14so4222902wmh.1
        for <linux-block@vger.kernel.org>; Sat, 19 Aug 2017 23:38:13 -0700 (PDT)
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816104935.GA30525@lst.de>
 <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
 <20170816151723.GA18932@lst.de>
 <d3ee0b6c-feac-8e40-f658-4791e454f60e@grimberg.me>
 <20170817073620.GA24372@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <434101e0-7efd-eb98-211e-3ae540fa73a1@grimberg.me>
Date: Sun, 20 Aug 2017 09:37:55 +0300
MIME-Version: 1.0
In-Reply-To: <20170817073620.GA24372@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> You want to see it done before we merge? Or are you asking if I
>> want to see it done? I designed it to be incremental and not
>> break existing transports.
>>
>> Personally I think that pci conversion will have to be incremental
>> and gradual as we need some preparations in place first. So if you are
>> reluctant to get it in without full conversion its ok, just note it will
>> take me some time to get both pci and fc converted.
> 
> I'd really like to see at least a demo PCI conversion.

Let me see what if I can allocate some time for it.

> Guess I need to take care of it then.

If you feel this is a gating item for inclusion then your help will be
highly appreciated.
