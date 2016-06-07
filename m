Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54707 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbcFGLkl (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 7 Jun 2016 07:40:41 -0400
Date: Tue, 7 Jun 2016 13:40:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Shaun Tancheff <shaun@tancheff.com>
Cc: util-linux@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] Zoned block device support
Message-ID: <20160607114039.urf62b6gqgxsrxuv@ws.net.home>
References: <1465229095-27651-1-git-send-email-shaun@tancheff.com>
 <20160607110534.lyhrwy2drpe6wbz7@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160607110534.lyhrwy2drpe6wbz7@ws.net.home>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 07, 2016 at 01:05:34PM +0200, Karel Zak wrote:
> On Mon, Jun 06, 2016 at 11:04:54AM -0500, Shaun Tancheff wrote:
> > ZBC/ZAC compliant devices such as Host Aware drives are now available.
> > 
> > This patch follows the pattern of blkdiscard to and zoned device
> > commands Open, Close and Reset as well as Report zones.
> 
> What is difference between zone "reset" and blkdiscard(8)?

Well, I read something more about SMR, it makes more sense now :-)

Maybe you can explain all the zones concept in the man page to make it
more usable for end-users.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
