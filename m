Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34103 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdAMWk7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 17:40:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so14812011wmi.1
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2017 14:40:58 -0800 (PST)
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
References: <1484334292-29933-1-git-send-email-jbacik@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0439c54d-228c-78fb-4790-94095ef39c93@grimberg.me>
Date: Sat, 14 Jan 2017 00:40:55 +0200
MIME-Version: 1.0
In-Reply-To: <1484334292-29933-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Josef,

> To prepare for dynamically adding new nbd devices to the system switch
> from using an array for the nbd devices and instead use an idr.  This
> copies what loop does for keeping track of its devices.

I think ida_simple_* is simpler and sufficient here isn't it?
