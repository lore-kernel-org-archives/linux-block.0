Return-Path: <linux-block-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:51762 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdGUM2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2017 08:28:37 -0400
Date: Fri, 21 Jul 2017 14:28:28 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Josef Bacik <jbacik@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: nbd drops connection on most writes
Message-ID: <20170721122828.hu5ohjr64rcmid75@angband.pl>
References: <20170721121439.ofwm3lfuzqjsvjok@angband.pl>
 <F5862F0D-20D5-4CEC-9FAB-C5ED306DDFB6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <F5862F0D-20D5-4CEC-9FAB-C5ED306DDFB6@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 21, 2017 at 12:22:51PM +0000, Josef Bacik wrote:
> Oh shit the default timeout is 0 if you don't set it in the client.  Use
> the timeout option with nbd client and it should fix it for you.  I'll
> send something up to make this a sane default.

Confirmed, adding a timeout=XXX argument makes it work.
Great, thanks!

-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
