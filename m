Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46255 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751485AbcLEVez (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Dec 2016 16:34:55 -0500
Date: Mon, 5 Dec 2016 16:34:29 -0500
From: Josef Bacik <jbacik@fb.com>
Subject: Re: [Nbd] [PATCH] nbd: use dev_err_ratelimited in io path
To: Eric Blake <eblake@redhat.com>
CC: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <mpa@pengutronix.de>, <nbd-general@lists.sourceforge.net>
Message-ID: <1480973669.12474.0@smtp.office365.com>
In-Reply-To: <c2544092-1e2a-3222-5134-ce8959ca377c@redhat.com>
References: <1480972829-30845-1-git-send-email-jbacik@fb.com>
        <c2544092-1e2a-3222-5134-ce8959ca377c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 5, 2016 at 4:27 PM, Eric Blake <eblake@redhat.com> wrote:
> On 12/05/2016 03:20 PM, Josef Bacik wrote:
>>  While doing stress tests we noticed that we'd get a lot of dmesg 
>> spam if
>>  we suddenly disconnected teh nbd device out of band.  Rate limite 
>> the
> 
> s/teh/the/
> s/limite/limit/

Thanks, I've updated my .vimrc to have spell check for git commits,

Josef

