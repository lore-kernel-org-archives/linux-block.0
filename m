Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:57272 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeBWPNO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 10:13:14 -0500
Date: Fri, 23 Feb 2018 08:13:13 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RESEND PATCH v2] Documentation/ABI: clean up
 sysfs-class-pktcdvd
Message-ID: <20180223081313.688cd1eb@lwn.net>
In-Reply-To: <20180223131632.GA21867@mordor.localdomain>
References: <20180223131632.GA21867@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 23 Feb 2018 18:46:32 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Clean up the sysfs documentation such that it is in the same format as
> described in Documentation/ABI/README. Mainly, the patch moves the
> attribute names to the 'What:' field. This might be useful for scripting
> and tracking changes in the ABI.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to the docs tree, thanks.

In general, I've been setting aside the sysfs ABI doc patches to see what
the reaction is to them.  I'm trying to catch up with the ones that
haven't been merged via another tree, but it wouldn't be entirely
surprising if I miss one.  Please don't hesitate to resend anything that
doesn't appear in linux-next in the near future.

Thanks,

jon
