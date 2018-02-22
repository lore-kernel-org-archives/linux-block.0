Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45059 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933219AbeBVQq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 11:46:28 -0500
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Jaco Kroon <jaco@uls.co.za>, linux-block@vger.kernel.org
Cc: Pieter Kruger <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
Date: Thu, 22 Feb 2018 08:46:28 -0800
MIME-Version: 1.0
In-Reply-To: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/22/18 02:58, Jaco Kroon wrote:
> We've been seeing sporadic IO lockups on recent kernels.

Are you using the legacy I/O stack or blk-mq? If you are not yet using 
blk-mq, can you switch to blk-mq + scsi-mq + dm-mq? If the lockup is 
reproducible with blk-mq, can you share the output of the following command:

(cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)

Thanks,

Bart.
