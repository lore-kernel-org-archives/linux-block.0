Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4843AECE587
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 11:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EB520873
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 11:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfJNL7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:59:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:49580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731446AbfJNL7z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 07:59:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E050B98A;
        Mon, 14 Oct 2019 11:59:53 +0000 (UTC)
Message-ID: <1571054381.19529.16.camel@suse.com>
Subject: Re: Lockup on USB and block devices
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Date:   Mon, 14 Oct 2019 13:59:41 +0200
In-Reply-To: <Pine.LNX.4.44L0.1910011427110.1991-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1910011427110.1991-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am Dienstag, den 01.10.2019, 14:31 -0400 schrieb Alan Stern:
> It looks like a problem with your xHCI USB host controller.  Normally a
> usb-storage transfer would be aborted after 90 seconds.  But if the
> host controller (or its driver) isn't working right, and the abort
> never completes, you end up with a situation like this -- usb-storage
> and the higher SCSI and block layers waiting indefinitely for an event
> that won't occur.

Hi,

that would imply that usb_unlink_urb() is malfunctioning
without taking down the whole bus. Is that likely?

	Regards
		Oliver

