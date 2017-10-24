Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:48821 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdJXFho (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2017 01:37:44 -0400
Received: by mail-it0-f54.google.com with SMTP id c3so8582360itc.3
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2017 22:37:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <14a149bb-32a8-cd78-e8b7-42dd89bbe5b1@intel.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFr-XbMOmOkz1yXwmG1t=77eSsUO2kU7kKV0V1wrfcmWKg@mail.gmail.com>
 <2cd4c5fc-cc04-ba44-bea6-4547d84de3e2@intel.com> <CAPDyKFqE7UYOYrjykpV0GnQ+hg2oGXpALgn_8yKsQk19Y4nmSQ@mail.gmail.com>
 <9a789f9b-a8c4-8ae7-8f93-0d76f674bded@intel.com> <CAPDyKFoLa_aX3j693_tfkuaSKNvGB-ERdf2-9r4iF-+c0NnP9g@mail.gmail.com>
 <d41eee41-796a-db93-d388-b36123ecc364@intel.com> <CAPDyKFrMqXWagkPOtPk-PBThSUrSogUP=iL+9XeyD9E8qkp=bw@mail.gmail.com>
 <1b8bec1b-7340-cb89-65c0-e09b17037ca4@intel.com> <CAPDyKFqoMVemtCSHBzfK5YTqLsGEr_v_z7o=HOKCwEdVz0tH_w@mail.gmail.com>
 <376e4bb9-cc86-36ae-91b6-48fef69e059a@intel.com> <b594f4e0-06ea-c9fc-fc2d-dd93bc401c6f@intel.com>
 <0e1f4dd2-2ab6-115b-11fd-72c3be3c61a8@intel.com> <14a149bb-32a8-cd78-e8b7-42dd89bbe5b1@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Oct 2017 07:37:43 +0200
Message-ID: <CAPDyKFq23Ak6g0HFRThvwToyxrPHsxZVgyw=BHhASdMMSb9JhQ@mail.gmail.com>
Subject: Re: [PATCH V8 00/14] mmc: Add Command Queue support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

+ Bartlomiej

[...]

>>>>> So my conclusion is, let's start a as you suggested, by not completing
>>>>> the request in ->done() as to maintain existing behavior. Then we can
>>>>> address optimizations on top, which very likely will involve doing
>>>>> changes to host drivers as well.
>>>>
>>>> Have you tested the latest version now?
>>>>
>>>
>>> Ping?
>>
>> Still ping?
>
> How is your silence in any way an acceptable way to execute your
> responsibilities as maintainer!

Seriously? You posted the new version Oct 13.

I had to make some late minute travel decisions, so unfortunate I
won't be able to test this on HW from this Friday.

However, you have completely ignored mine, Linus and Bartlomiej's
comments about that we want the blkmq port being a separate patch(es)
and then make the CMDQ patches on top. This worries me, because it
seems like our messages don't reach you.

Kind regards
Uffe
