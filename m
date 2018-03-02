Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38507 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428981AbeCBO7R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Mar 2018 09:59:17 -0500
Received: by mail-pl0-f66.google.com with SMTP id m22-v6so2306938pls.5
        for <linux-block@vger.kernel.org>; Fri, 02 Mar 2018 06:59:17 -0800 (PST)
Subject: Re: [PATCH] bcache: don't attach backing with duplicate UUID
From: Michael Lyle <mlyle@lyle.org>
To: tang.junhui@zte.com.cn
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1519969549-28993-1-git-send-email-tang.junhui@zte.com.cn>
 <a3e342db-f17b-251c-07c5-8309901b7dc0@lyle.org>
Message-ID: <84f53d52-7aec-e636-3d27-605a0245fc99@lyle.org>
Date: Fri, 2 Mar 2018 06:59:14 -0800
MIME-Version: 1.0
In-Reply-To: <a3e342db-f17b-251c-07c5-8309901b7dc0@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/02/2018 06:55 AM, Michael Lyle wrote:
> Hi Tang Junhui---
> 
> On 03/01/2018 09:45 PM, tang.junhui@zte.com.cn wrote:
>> From: Tang Junhui <tang.junhui@zte.com.cn>
>>
>> Hello, Mike
>>
>> This patch looks good, but has some conflicts with this patch:
>> bcache: fix for data collapse after re-attaching an attached device
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=73ac105be390c1de42a2f21643c9778a5e002930
>> Could you modify your fix base on the previous patch?
> 
> That doesn't make sense.  This patch was generated from a current tree
> where it's applied on top of that: (It's based on next when it should
> really be based on Linus's tree, but it doesn't matter for patch
> application because there's no changes in next right now to bcache that
> aren't in Linus's tree).
> 
> https://github.com/mlyle/linux/commit/502c38831b42100ac5d3319c792a66c7e01357ae
> 
> May I add your reviewed-by so I can send this (and your fix) upstream?
> 
> Mike

Just to confirm this all works---

mlyle@midnight:~/trees/linux$ git checkout linus/master
Note: checking out 'linus/master'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 5d60e057d127... Merge tag 'drm-fixes-for-v4.16-rc4' of
git://people.freedesktop.org/~airlied/linux
mlyle@midnight:~/trees/linux$ git am
0001-bcache-fix-crashes-in-duplicate-cache-device-registe.patch
Applying: bcache: fix crashes in duplicate cache device register
mlyle@midnight:~/trees/linux$ git am
0001-bcache-don-t-attach-backing-with-duplicate-UUID.patch
Applying: bcache: don't attach backing with duplicate UUID

Mike
