Return-Path: <linux-block-owner@vger.kernel.org>
Received: from icebox.esperi.org.uk ([81.187.191.129]:51672 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeA2M5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jan 2018 07:57:18 -0500
From: Nix <nix@esperi.org.uk>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Michael Lyle <mlyle@lyle.org>,
        Junhui Tang <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v4 13/13] bcache: add stop_when_cache_set_failed to struct cached_dev
References: <20180127142406.89741-1-colyli@suse.de>
        <20180127142406.89741-14-colyli@suse.de>
Date: Mon, 29 Jan 2018 12:57:07 +0000
In-Reply-To: <20180127142406.89741-14-colyli@suse.de> (Coly Li's message of
        "Sat, 27 Jan 2018 22:24:06 +0800")
Message-ID: <87inbkesbg.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 27 Jan 2018, Coly Li said:

> Current bcache failure handling code will stop all attached bcache devices
> when the cache set is broken or disconnected. This is desired behavior for
> most of enterprise or cloud use cases, but maybe not for low end
> configuration. Nix <nix@esperi.org.uk> points out, users may still want to
> access the bcache device after cache device failed, for example on laptops.

Actually I'm much interested in the server use case. On laptops, it's
relatively easy to recover if you know what you're doing, because they
usually have a user in front of them with console access -- but if a
remote headless server with a hundred users a thousand miles away has
its cache device wear out I would really rather the hundred users get
served, if more slowly, rather than the whole machine going down for
hours or days until I can get someone there to bash on the hardware!

(Sure, ideally you'd detect the wearing out in advance, but SSDs are not
always nice and helpful like that and sometimes just go instantly
readonly or simply vanish off the bus entirely without warning.)

-- 
NULL && (void)
