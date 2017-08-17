Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37873 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdHQHVM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 03:21:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id z91so3752231wrc.4
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2017 00:21:11 -0700 (PDT)
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d3ee0b6c-feac-8e40-f658-4791e454f60e@grimberg.me>
Date: Thu, 17 Aug 2017 10:21:08 +0300
MIME-Version: 1.0
In-Reply-To: <20170816151723.GA18932@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Having said that, I'm very much open to suggestions if you have anything
>> better in mind...
> 
> Not too many suggestions - you want to see it done before we go on
> merging the code..

Something is not adding up in your reply :)

You want to see it done before we merge? Or are you asking if I
want to see it done? I designed it to be incremental and not
break existing transports.

Personally I think that pci conversion will have to be incremental
and gradual as we need some preparations in place first. So if you are
reluctant to get it in without full conversion its ok, just note it will
take me some time to get both pci and fc converted.
