Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37363 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJaDVR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 23:21:17 -0400
Subject: Re: [PATCH v2] block: fix rdma queue mapping
To: "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc: Steve Wise <swise@opengridcomputing.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        'Max Gurtovoy' <maxg@mellanox.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <20181017163720.GA23798@lst.de>
 <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
 <00dd01d46ad0$6eb82250$4c2866f0$@opengridcomputing.com>
 <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
 <20181024000923.GA17352@ssaleem-MOBL4.amr.corp.intel.com>
 <60315f82-ebc1-838d-4757-c27b9bb650ff@grimberg.me>
 <9DD61F30A802C4429A01CA4200E302A7A2FFFC0B@fmsmsx116.amr.corp.intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c7fcc95b-655f-2318-4a73-441c7f694225@grimberg.me>
Date: Tue, 30 Oct 2018 11:26:39 -0700
MIME-Version: 1.0
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A2FFFC0B@fmsmsx116.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Subject: Re: [PATCH v2] block: fix rdma queue mapping
>>
>>
>>> Sagi - From what I can tell, i40iw is also exposed to this same issue
>>> if the IRQ affinity is configured by user.
>>
>> managed affinity does not allow setting smp_affinity from userspace.
> 
> OK. But our device IRQs are not set-up as to be managed affinity based and can be tuned by user.
> And it seems that is reasonable approach since we can never tell ahead of time what might be an optimal config. for a particular workload.

I understand, but its not necessarily the case, the vast majority of
users don't touch (or at least don't want to) and managed affinity gives
you benefits of linear assignment good practice (among others).

The same argument can be made for a number of pcie devices that do use
managed affinity, but the choice was to get it right from the start.
Still not sure why (r)nics are different with that respect.

Anyways, I was just asking, wasn't telling you to go and use it..
