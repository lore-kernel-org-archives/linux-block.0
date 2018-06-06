Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44821 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbeFFO0W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 10:26:22 -0400
Date: Wed, 6 Jun 2018 08:28:57 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        osandov@osandov.com, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com
Subject: Re: blktests block/019 lead system hang
Message-ID: <20180606142857.GA19462@localhost.localdomain>
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
 <20180605172112.GC17057@localhost.localdomain>
 <1cbee034-d237-104d-bf5a-33e373821301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1cbee034-d237-104d-bf5a-33e373821301@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 06, 2018 at 01:42:15PM +0800, Yi Zhang wrote:
> Here is the output, and I can see "HotPlug+ Surprise+" on SltCap

Thanks. That looks like a perfectly capable port. I even have the same
switch in one of my machines, but the test doesn't trigger fatal
firmware-first errors.

Might need to query something about the platform to know how it treats
link-downs before proceeding with the test (don't know off the top of
my head; will do some digging).
