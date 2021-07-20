Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7AC07E9B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 05:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0859C6113C
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 05:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbhGTEqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 00:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237572AbhGTEqO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 00:46:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7213461004;
        Tue, 20 Jul 2021 05:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626758810;
        bh=wG76adtpPyP0DbYkuWx0H/oBkyeSrBGgr6j8z/70ftI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dq0Q/Why6jwvkBtkoVsH6BX7F0I9T7TiNP53EtPYD+cDQcVPXQ8RDjjH71L5BfybA
         E6DAbq20OTayodUXK2DrTPZV3+XMmt8bZEwJX0cfLlHurNeWN1dLiBCrXxNLL8HjUP
         6p4Re23bWwiAG0kLYfbK1XEF2f9hlpV2gJ7lePJk=
Date:   Tue, 20 Jul 2021 07:26:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-fs@vger.kernel.org, linux-block@vger.kernel.org,
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
Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YPZemNCOa6oGUa25@kroah.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 19, 2021 at 08:31:05PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Azure Blob provides scalable, secure and shared storage services for Azure.
> 
> This driver adds support for accelerated access to Azure Blob storage. As an
> alternative to REST APIs, it provides a fast data path that uses host native
> network stack and direct data link for storage server access.

Thank you for fixing up the license info, but you did not include any
information here about how to use this, where the userspace tools are,
nor why you are going around the existing kernel block layer and proof
that going around the block layer is a good idea.

thanks,

greg k-h
