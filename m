Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36572 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeBDMy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Feb 2018 07:54:59 -0500
Received: by mail-lf0-f65.google.com with SMTP id t79so38013908lfe.3
        for <linux-block@vger.kernel.org>; Sun, 04 Feb 2018 04:54:58 -0800 (PST)
Subject: Re: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
 <1517364411-22386-5-git-send-email-javier@cnexlabs.com>
 <bdde0655-0904-0bf1-7029-51708fcff8b3@lightnvm.io>
 <F1AA3AA6-8F23-43A8-9C4C-5F684A80782C@cnexlabs.com>
 <33896b20-c555-7c60-ed47-28156f4c93bf@lightnvm.io>
 <DEB69E27-635B-4B4F-ABA4-08BEC14B291F@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <71151484-9bee-512b-cfe4-dd5bdc1b4711@lightnvm.io>
Date: Sun, 4 Feb 2018 13:54:56 +0100
MIME-Version: 1.0
In-Reply-To: <DEB69E27-635B-4B4F-ABA4-08BEC14B291F@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/04/2018 11:37 AM, Javier Gonzalez wrote:
> 
>> On 31 Jan 2018, at 19.24, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 01/31/2018 10:13 AM, Javier Gonzalez wrote:
>>>> On 31 Jan 2018, at 16.51, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>> I have a patches abstracting this, which I think it makes it cleaner. I can push it next week for review. I’m traveling this week. (If you want to get a glimpse I can point you to the code).
>>
>> Yes, please do. Thanks
> 
> This is the release candidate for 2.0 support based on 4.17. I'll rebase
> on top of you 2.0 support. We'll see if all changes make it to 4.17
> then.
> 
> https://github.com/OpenChannelSSD/linux/tree/for-4.17/spec20
> 
> Javier
> 

Great. I look forward to be patches being cleaned up and posted. I do 
see some nitpicks here and there, which we properly can take a couple of 
stabs at.

One think that generally stands out to me is the "if 1.2 support", else, 
... statements. These could be structured better by having dedicated 
setup functions for 1.2 and 2.0.
