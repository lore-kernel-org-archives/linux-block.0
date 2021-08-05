Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F9FC432BE
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1185161004
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhHESRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232969AbhHESRU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Aug 2021 14:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DD556044F;
        Thu,  5 Aug 2021 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628187426;
        bh=BHkLr8RyM5LfUpw3kjUHGAEgyKjazgrTeuyD8z7tr7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JRrBH6XoeiVtgg/0EXT3NHWAM6gpsR5pntg8vy4jRMu6XrVfC/+OfuOKoZy6F2TBE
         P8yQiWVD+JhHK8RP9hNBWFLaeWgxtn3LwmUBFRTaxVhOAmBpbqATPPHySc4VXKjbkO
         W1Bo/cON+KPowuhm5xAWkPRF4WpAGFCRB2/JwqyU=
Date:   Thu, 5 Aug 2021 20:17:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     longli@linuxonhyperv.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YQwrH58lpXxeL2cP@kroah.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
 <b6404b38-9ea2-b438-dc1b-1196f8e4a158@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6404b38-9ea2-b438-dc1b-1196f8e4a158@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 05, 2021 at 10:06:03AM -0700, Bart Van Assche wrote:
> On 8/5/21 12:00 AM, longli@linuxonhyperv.com wrote:
> > diff --git a/include/uapi/misc/hv_azure_blob.h b/include/uapi/misc/hv_azure_blob.h
> > new file mode 100644
> > index 0000000..87a3f77
> > --- /dev/null
> > +++ b/include/uapi/misc/hv_azure_blob.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +/* Copyright (c) 2021 Microsoft Corporation. */
> > +
> > +#ifndef _AZ_BLOB_H
> > +#define _AZ_BLOB_H
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/uuid.h>
> > +#include <linux/types.h>
> > +
> > +/* user-mode sync request sent through ioctl */
> > +struct az_blob_request_sync_response {
> > +	__u32 status;
> > +	__u32 response_len;
> > +};
> > +
> > +struct az_blob_request_sync {
> > +	guid_t guid;
> > +	__u32 timeout;
> > +	__u32 request_len;
> > +	__u32 response_len;
> > +	__u32 data_len;
> > +	__u32 data_valid;
> > +	__aligned_u64 request_buffer;
> > +	__aligned_u64 response_buffer;
> > +	__aligned_u64 data_buffer;
> > +	struct az_blob_request_sync_response response;
> > +};
> > +
> > +#define AZ_BLOB_MAGIC_NUMBER	'R'
> > +#define IOCTL_AZ_BLOB_DRIVER_USER_REQUEST \
> > +		_IOWR(AZ_BLOB_MAGIC_NUMBER, 0xf0, \
> > +			struct az_blob_request_sync)
> > +
> > +#endif /* define _AZ_BLOB_H */
> 
> So this driver only supports synchronous requests? Is it likely that users
> will ask for support of an API that supports having multiple requests
> outstanding at the same time without having to create multiple user space
> threads?

They seem to want to go around the block layer and reinvent it all from
scratch, which is crazy, so let them have their slow i/o :(


