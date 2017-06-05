Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5688 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdFEVGe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jun 2017 17:06:34 -0400
Date: Mon, 5 Jun 2017 14:52:26 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: Re: Opal userspace
Message-ID: <20170605205225.tcn4ow7v7ez4csuv@sbauer-Z170X-UD5>
References: <20170604071503.GA32121@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170604071503.GA32121@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 04, 2017 at 09:15:03AM +0200, Christoph Hellwig wrote:
> Hi Scott,
> 
> is https://github.com/ScottyBauer/sed-opal-temp/ still the latest and
> greatest in terms of OPAL userspace?  The temp name always sounds a bit
> odd..

Yeah it currently, is. I want to move it out from my personal repo to perhaps
under linux-nvme project. Even though it's not really nvme-centric I think it
would be better if there was more of group control of the project, not just me.

If we want to put it on Infradead that's fine too, I don't really care where it
lives. If people are fine with it hanging out under the linux-nvme project I'll
work with Keith when he gets back from vacation.
