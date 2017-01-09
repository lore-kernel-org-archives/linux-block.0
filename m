Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway21.websitewelcome.com ([192.185.45.147]:39339 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763466AbdAIThK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Jan 2017 14:37:10 -0500
Received: from cm6.websitewelcome.com (cm6.websitewelcome.com [108.167.139.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id AB611400FD789
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2017 13:37:07 -0600 (CST)
Message-ID: <1aa7cc9028eab7ebc2a2e9c6bb48e43c.squirrel@webmail.raithlin.com>
In-Reply-To: <20161219154256.GB3512@localhost.localdomain>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
    <1481914491-21456-3-git-send-email-sbates@raithlin.com>
    <20161219154256.GB3512@localhost.localdomain>
Date: Mon, 9 Jan 2017 13:37:06 -0600
Subject: Re: [PATCH 2/2] nvme: improve cmb sysfs reporting
From: "Stephen Bates" <sbates@raithlin.com>
To: "Jon Derrick" <jonathan.derrick@intel.com>
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        james_p_freyensee@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> Minor nit below
>
>
>> +
>> +	for (i = NVME_CMB_CAP_SQS; i <= NVME_CMB_CAP_WDS; i++)
>>
> I'd prefer seeing (i = 0; i < ARRAY_SIZE(..); i++) because it provides
> automatic bounds checking against future code.
>

Thanks Jon, I will take a look at doing this in a V1.

Stephen
