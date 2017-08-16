Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32811 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbdHPJq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 05:46:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id q189so4175166wmd.0
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2017 02:46:28 -0700 (PDT)
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ca050b6b-6694-834c-51ab-856b516bd6ad@grimberg.me>
Date: Wed, 16 Aug 2017 12:46:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170816093559.GA24709@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>> Sure, should I have it on top of the affinity patches or not?
> 
> For now get any tree you have out to take a look.  In the longer
> run we'll need to decide how we want to deal with the merge
> of the two trees.  In general having to depend on the RDMA
> tree is a major risk because it's maintainance is so unreliable.

Its really a small conflict, easy enough to get it without. The problem
that no matter what I do, one tree would conflict...

> If it's in a branch of its own we could pull it in through and
> send that bit through both trees.

We can do that, should I use the nvme tree for that? or maybe once we
converge on the patch set?
