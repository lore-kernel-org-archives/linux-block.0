Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0000C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC77206F0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLCJrp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:47:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:56108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCJro (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 04:47:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F041EAF47;
        Tue,  3 Dec 2019 09:47:42 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] xen/xenbus: reference count registered modules
To:     Paul Durrant <pdurrant@amazon.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20191202114117.1264-1-pdurrant@amazon.com>
 <20191202114117.1264-2-pdurrant@amazon.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <c784e57a-46ea-a839-8c0c-5a299aa5a64f@suse.com>
Date:   Tue, 3 Dec 2019 10:47:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202114117.1264-2-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.12.2019 12:41, Paul Durrant wrote:
> To prevent a PV driver module being removed whilst attached to its other
> end, and hence xenbus calling into potentially invalid text, take a
> reference on the module before calling the probe() method (dropping it if
> unsuccessful) and drop the reference after returning from the remove()
> method.
> 
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>
with ...

> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -232,9 +232,16 @@ int xenbus_dev_probe(struct device *_dev)
>  		return err;
>  	}
>  
> +	if (!try_module_get(drv->driver.owner)) {
> +		dev_warn(&dev->dev, "failed to acquire module reference on '%s'.\n",
> +			 drv->driver.name);

... perhaps the full stop dropped here and ...

> +		err = -ESRCH;
> +		goto fail;
> +        }

... (definitely) indentation here changed to use a tab.

Jan
