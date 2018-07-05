Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6339 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbeGESN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jul 2018 14:13:56 -0400
Subject: Re: [PATCH blktests] dir-locals: fix indenation with Emacs
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
References: <20180704115938.15060-1-jthumshirn@suse.de>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <70824b8f-a6e3-41a4-3ac9-bbf5b2e6618f@wdc.com>
Date: Thu, 5 Jul 2018 11:13:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180704115938.15060-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/04/18 04:59, Johannes Thumshirn wrote:
> A recent update of Emacs broke .dir-locals.el's shell indendation
> setting.

Please fix the spelling of "indentation" in the subject and in the above 
sentence. Additionally, the previous patch for this file had 
"dir-locals.el:" as subject-prefix. Should this patch have the same 
subject prefix?

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
