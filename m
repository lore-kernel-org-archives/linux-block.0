Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00272701.pphosted.com ([67.231.145.144]:55634 "EHLO
        mx0a-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932157AbeCIVN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Mar 2018 16:13:58 -0500
To: linux-block@vger.kernel.org
Cc: Thomas Schmitt <scdbackup@gmx.net>
From: Steve Kenton <skenton@ou.edu>
Subject: Newly initialized DVD+RW treated as zero length by the block layer
Message-ID: <da76727f-22a3-e597-4fe5-7d5c1e6422da@ou.edu>
Date: Fri, 9 Mar 2018 15:13:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A couple of weeks ago I submitted a proposed patch to extend BLKRRPART

It got zero response which I assume means no dice to that approach.

So, does anyone have another suggestion about how to deal with this issue?

The readable size of new, factory blank, optical media can change via user
space ioctl(SG_IO) commands to format overwritable media such as DVD+RW for
a UDF filesystem or write to sequential media such as DVD-R for an ISO-9660
filesystem. However there appears to be no easy way to update the size used
by the block layer from the initial value of zero. Traditionally, 
ejecting and
reinserting the media is the workaround to this long standing issue which
programs such as growisofs use by automatically opening and closing the tray
at the end of a session so the newly created filesystem becomes mountable
and readable.


Steve Kenton
