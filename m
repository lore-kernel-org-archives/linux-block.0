Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39852 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752089AbdDNUK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 16:10:29 -0400
Subject: Re: [PATCH block-tree] net: off by one in inet6_pton()
To: Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20170413194231.GD591@mwanda>
CC: Wei Tang <tangwei@cmss.chinamobile.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        <netdev@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <fa3631c5-8f5a-1d45-0968-33a4219aab24@fb.com>
Date: Fri, 14 Apr 2017 14:09:30 -0600
MIME-Version: 1.0
In-Reply-To: <20170413194231.GD591@mwanda>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/13/2017 01:42 PM, Dan Carpenter wrote:
> If "scope_len" is sizeof(scope_id) then we would put the NUL terminator
> one space beyond the end of the buffer.

Added, thanks Dan.

-- 
Jens Axboe
