Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34629 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdHPKJF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 06:09:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id x43so2181909wrb.1
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2017 03:09:04 -0700 (PDT)
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816081605.GA29784@infradead.org>
 <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me>
 <20170816093559.GA24709@lst.de>
 <ca050b6b-6694-834c-51ab-856b516bd6ad@grimberg.me>
 <20170816095707.GA26561@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7809533c-4b09-0d40-634e-0250046abd66@grimberg.me>
Date: Wed, 16 Aug 2017 13:09:01 +0300
MIME-Version: 1.0
In-Reply-To: <20170816095707.GA26561@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>>> For now get any tree you have out to take a look.  In the longer
>>> run we'll need to decide how we want to deal with the merge
>>> of the two trees.  In general having to depend on the RDMA
>>> tree is a major risk because it's maintainance is so unreliable.
>>
>> Its really a small conflict, easy enough to get it without. The problem
>> that no matter what I do, one tree would conflict...
> 
> Let's keep the refactoring self contained in nvme now and sort out
> the small conflict when the rdma tree is merge (which is alsmost
> certainly going to be after the block tree)

Sure, the patch set on top of nvme-4.14 (without the affinity patches)
is at:

git://git.infradead.org/users/sagi/linux.git nvme-central-er-4.14

Cheers,
