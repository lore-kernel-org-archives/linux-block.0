Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61824 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbeGLUqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jul 2018 16:46:42 -0400
Subject: Re: [PATCH] block: skd: Use %pad printk format for dma_addr_t values
To: Helge Deller <deller@gmx.de>, linux-block@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org
References: <20180712202916.GA32416@ls3530.fritz.box>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <ad3b2585-2b36-2078-4a67-93cf05b70824@wdc.com>
Date: Thu, 12 Jul 2018 13:35:24 -0700
MIME-Version: 1.0
In-Reply-To: <20180712202916.GA32416@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/12/18 13:29, Helge Deller wrote:
> Use the existing %pad printk format to print dma_addr_t values.
> This avoids the following warnings when compiling on the parisc64 platform:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
