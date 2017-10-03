Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:49122 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdJCPAz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 11:00:55 -0400
Received: by mail-ua0-f181.google.com with SMTP id v12so5369407uaf.5
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 08:00:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6DF6EE74-01FC-4C86-98E1-E437A41D3CB7@lightnvm.io>
References: <1507038524-24587-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <5f64209d-ba28-a642-ed44-66a5eced9a99@virtuozzo.com> <9AF41216-3CB7-4AFA-B461-0957074AF0A5@lightnvm.io>
 <2aa049d5-3c31-eabc-a995-499807837a19@virtuozzo.com> <A9B2CD92-C7CE-478F-B361-704D1EFE7532@lightnvm.io>
 <6DF6EE74-01FC-4C86-98E1-E437A41D3CB7@lightnvm.io>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Tue, 3 Oct 2017 17:00:52 +0200
Message-ID: <CANr-nt2L-4y0jj1xV2y8vg=JjbXXBvoLL=o_npqB9WHQDJm4uQ@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: use vfree_atomic when freeing line metadata
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks for the review Andrey, i'll send a new patch removing the lock.
