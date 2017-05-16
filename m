Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 107-204-215-49.lightspeed.sntcca.sbcglobal.net ([107.204.215.49]:47486
        "EHLO mail.aaazen.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEPVO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2017 17:14:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by thursday.test (OpenSMTPD) with ESMTP id 4ca53ca1
        for <linux-block@vger.kernel.org>;
        Tue, 16 May 2017 21:07:49 +0000 (UTC)
Date: Tue, 16 May 2017 14:07:49 -0700 (PDT)
From: Richard <richard@aaazen.com>
To: linux-block@vger.kernel.org
Subject: Bug 109761 FreeBSD UFS2 file systems are not recognized on MS DOS
 (MBR) partitions
Message-ID: <alpine.LNX.2.20.1705161353060.20651@thursday.test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

To allow FreeBSD filesystems to be recognized on Linux,
I submitted the following bug and patch in December 2015.

  https://bugzilla.kernel.org/show_bug.cgi?id=109761

The patch still works on current kernels (4.4.68 4.9.28 4.12.1-rc1)

Richard Narron
richard@aaazen.com
(comet.berkeley@gmail.com)
