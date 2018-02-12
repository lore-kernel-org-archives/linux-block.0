Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1286 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeBLQss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:48 -0500
Subject: Re: vgdisplay hang on iSCSI session
To: Jean-Louis Dupond <jean-louis@dupond.be>,
        linux-block@vger.kernel.org
References: <b175d4715df19110064f986599ff87c4@dupond.be>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <696a6c0c-2629-6af0-b5c2-fb5ce56d5f2a@wdc.com>
Date: Mon, 12 Feb 2018 08:48:47 -0800
MIME-Version: 1.0
In-Reply-To: <b175d4715df19110064f986599ff87c4@dupond.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/05/18 08:01, Jean-Louis Dupond wrote:
> We've got some "strange" issue on a Xen hypervisor with CentOS 6 and 
> 4.9.63-29.el6.x86_6 kernel.

Hello Jean-Louis,

Since this behavior was observed with a distro kernel I think a support 
request should be submitted to the vendor of that kernel. That vendor 
will be able to tell you whether or not a fix is already available for 
what looks like a hang in the iSCSI initiator. A possible alternative is 
that you install a recent upstream kernel on the system (e.g. v4.15.3), 
reproduce the issue and provide a dump of the information under 
/sys/kernel/debug/block. Recent kernels namely make detailed information 
available under /sys/kernel/debug/block for blk-mq drivers about which 
requests are in progress. That information will allow to figure out in 
which block driver a request got stuck.

Thanks,

Bart.
