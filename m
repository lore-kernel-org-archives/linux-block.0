Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38924 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbeJ3Fd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 01:33:57 -0400
Message-ID: <1540845815.196084.97.camel@acm.org>
Subject: Re: [PATCH 2/2] scsi: remove the SCSI OSD library
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, ooo@electrozaur.com,
        martin.petersen@oracle.com
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Oct 2018 13:43:35 -0700
In-Reply-To: <20181027082019.20838-3-hch@lst.de>
References: <20181027082019.20838-1-hch@lst.de>
         <20181027082019.20838-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, 2018-10-27 at 10:20 +-0200, Christoph Hellwig wrote:
+AD4 Now that all the users are gone the SCSI OSD library can be removed
+AD4 as well.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
