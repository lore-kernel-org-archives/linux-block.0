Return-Path: <linux-block-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:57274 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdDKPkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 11:40:11 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glb-linux-block@m.gmane.org>)
        id 1cxxti-00048l-Pg
        for linux-block@vger.kernel.org; Tue, 11 Apr 2017 17:40:02 +0200
To: linux-block@vger.kernel.org
From: Holger =?iso-8859-1?q?Hoffst=E4tte?=
        <holger@applied-asynchrony.com>
Subject: Re: WBT for SQ devices interface
Date: Tue, 11 Apr 2017 15:16:16 +0000 (UTC)
Message-ID: <pan$69397$61f9566$49954c7$3612ea5f@applied-asynchrony.com>
References: <20170411093827.GC2471@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 11 Apr 2017 11:38:27 +0200, Jan Kara wrote:

> when testing my fix for 0-day reports with writeback throttling I came
> across somewhat unexpected behavior with user interface of writeback
> throttling. So currently if CFQ is used as an IO scheduler, we disable
> writeback throttling because they don't go well together. However when user
> has CONFIG_BLK_WBT_SQ=y and switches IO scheduler to NOOP or DEADLINE
> writeback throttling still stays disabled. This is somewhat unexpected
> especially because the switching of IO scheduler from CFQ to something else
> can have happened behind user's back by some udev rule or so. So basically
> CONFIG_DEFAULT_CFQ=y and CONFIG_BLK_WBT_SQ=y don't make sense together.

:(

> So do people thing we should enable WBT if CONFIG_BLK_WBT_SQ=y and IO
> scheduler is switched from CFQ to something else?

Yes please. If a scheduler doesn't like WBT then that is its own problem.
Deadline with WBT has worked fine for me.

-h
