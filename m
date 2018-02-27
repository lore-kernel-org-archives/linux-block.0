Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46140 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeB0SdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 13:33:21 -0500
Received: by mail-pf0-f193.google.com with SMTP id z10so3968003pfh.13
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 10:33:21 -0800 (PST)
Subject: Re: [PATCH v7 0/9] bcache: device failure handling improvement
From: Michael Lyle <mlyle@lyle.org>
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180227165557.20442-1-colyli@suse.de>
 <d49160a9-cfee-1547-f08a-dcf83daba6f6@lyle.org>
Message-ID: <881d16b5-e356-bb2a-459d-15c9ad11ca16@lyle.org>
Date: Tue, 27 Feb 2018 10:33:18 -0800
MIME-Version: 1.0
In-Reply-To: <d49160a9-cfee-1547-f08a-dcf83daba6f6@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/27/2018 10:29 AM, Michael Lyle wrote:
> Hi Coly Li--
> 
> On 02/27/2018 08:55 AM, Coly Li wrote:
>> Hi maintainers and folks,
>>
>> This patch set tries to improve bcache device failure handling, includes
>> cache device and backing device failures.
> 
> I have applied 1, 2, 4 & 6 from this series to my 4.17 bcache-for-next
> for testing.

Correction: I meant 1, 2, 5 & 6.

> 
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
