Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36001 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeA2ItB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jan 2018 03:49:01 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so32034774wmc.1
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2018 00:49:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517070766.3012.16.camel@HansenPartnership.com>
References: <CACj3i73kv3w_7JuYUi_iL6_2tVTYmj+HZBStfP6oEshz2Enx1w@mail.gmail.com>
 <1517070766.3012.16.camel@HansenPartnership.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Mon, 29 Jan 2018 09:48:39 +0100
Message-ID: <CACj3i70kNw2kwqBgypqWVb7kMHBx5RZcNvHi4iXdg10+kXn8=Q@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Springfield: smart and automated storage
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Justin Mitchell <jumitche@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jan 27, 2018 at 5:32 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Sat, 2018-01-27 at 09:37 +0100, Jan Tulak wrote:
>> Springfield is a collection of projects unifying multiple levels of
>> the storage stack and providing a general API for automation, health
>> and status monitoring, as well as sane and easy configuration across
>> multiple levels of the storage stack. It is a scalable solution,
>> working from a single node to large deployments with a mix of base
>> metal, containers and VMs. For the first time, it was presented on
>> Vault 2017 in a birds of a feather session.
>>
>> Springfield builds upon and enhances the existing work of those
>> projects:
>> * udisks
>> * libblockdev
>> * blivet
>> * libstoragemgmt
>>
>> It is a coordinated effort to overcome many of the shortcomings of
>> the current situation and provide a unified approach to storage
>> management, so there is nothing like a binary or a library with the
>> name “Springfield.”
>>
>> An example of things we are trying to tackle is a useful storage
>> reporting, like notifications about filesystem being full, especially
>> with thin provisioning and multiple levels of the storage stack,
>> where
>> the user-visible status is not a true representation of what is
>> happening underneath.
>>
>> We want to see how the community sees this effort. What shortcomings
>> of the current situation in storage layering can Springfield address
>> (is there something we don’t see, but a project like this could
>> help)? How would you use it, or what would make it more useful to
>> you?
>
> Do you have a link to the project page and the source tree(s)?
>

Sure, for Springfield the website is: https://springfield-project.github.io/

Each of the listed projects has it's own repositories:
https://github.com/storaged-project/udisks
https://github.com/libstorage/libstoragemgmt
https://github.com/storaged-project/libblockdev
https://github.com/storaged-project/blivet

Cheers,
Jan
