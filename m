Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:50460 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbeC0C4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Mar 2018 22:56:08 -0400
Subject: Re: blk-mq and CPU hotplug error
To: joserz@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc: hch@lst.de
References: <20180326212550.GC4100@pacoca>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <92fa5d9c-7ee5-337c-b22c-345d519eb1e9@oracle.com>
Date: Tue, 27 Mar 2018 10:56:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180326212550.GC4100@pacoca>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jose

On 03/27/2018 05:25 AM, joserz@linux.vnet.ibm.com wrote:
> Hello everyone!
> 
> I'm running Ubuntu 18.04 (4.15.0-12-generic) in KVM/QEMU (powerpc64le).
> Everything looks good until I try to hotplug CPUs in my VM. As soon as I
> do that I get the following error in my VM dmesg:

Please refer to the following commit:
20e4d813 blk-mq: simplify queue mapping & schedule with each possisble CPU
84676c1 genirq/affinity: assign vectors to all possible CPUs

Thanks
Jianchao
