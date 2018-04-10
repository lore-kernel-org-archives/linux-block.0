Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41267 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJPhK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Apr 2018 11:37:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id 188-v6so11568126oih.8
        for <linux-block@vger.kernel.org>; Tue, 10 Apr 2018 08:37:10 -0700 (PDT)
In-Reply-To: 
To: linux-block@vger.kernel.org
From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Cc: linux-nvme@lists.infradead.org, austin_bolen@dell.com,
        Alex_Gagniuc@Dellteam.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
Message-ID: <696b572b-c1b9-e192-ee2c-78b522019266@gmail.com>
Date: Tue, 10 Apr 2018 10:37:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I've observed a very nasty NULL pointer dereference with NVME drives on
hot-unplug [1]. While I haven't gone in the details of this change, it
does fix the NULL dereference I've been seeing.

Alex

[1] http://lists.infradead.org/pipermail/linux-nvme/2018-April/016623.html
