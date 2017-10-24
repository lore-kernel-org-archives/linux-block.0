Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14283 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932189AbdJXJ0u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2017 05:26:50 -0400
Subject: Re: [PATCH V8 00/14] mmc: Add Command Queue support
To: Ulf Hansson <ulf.hansson@linaro.org>
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
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFr-XbMOmOkz1yXwmG1t=77eSsUO2kU7kKV0V1wrfcmWKg@mail.gmail.com>
 <2cd4c5fc-cc04-ba44-bea6-4547d84de3e2@intel.com>
 <CAPDyKFqE7UYOYrjykpV0GnQ+hg2oGXpALgn_8yKsQk19Y4nmSQ@mail.gmail.com>
 <9a789f9b-a8c4-8ae7-8f93-0d76f674bded@intel.com>
 <CAPDyKFoLa_aX3j693_tfkuaSKNvGB-ERdf2-9r4iF-+c0NnP9g@mail.gmail.com>
 <d41eee41-796a-db93-d388-b36123ecc364@intel.com>
 <CAPDyKFrMqXWagkPOtPk-PBThSUrSogUP=iL+9XeyD9E8qkp=bw@mail.gmail.com>
 <1b8bec1b-7340-cb89-65c0-e09b17037ca4@intel.com>
 <CAPDyKFqoMVemtCSHBzfK5YTqLsGEr_v_z7o=HOKCwEdVz0tH_w@mail.gmail.com>
 <376e4bb9-cc86-36ae-91b6-48fef69e059a@intel.com>
 <b594f4e0-06ea-c9fc-fc2d-dd93bc401c6f@intel.com>
 <0e1f4dd2-2ab6-115b-11fd-72c3be3c61a8@intel.com>
 <14a149bb-32a8-cd78-e8b7-42dd89bbe5b1@intel.com>
 <CAPDyKFq23Ak6g0HFRThvwToyxrPHsxZVgyw=BHhASdMMSb9JhQ@mail.gmail.com>
 <2ff0a8ab-62dd-d46f-8554-2b8214a78740@intel.com>
 <CAPDyKFrz3ko-vhHR8Yj+i2JhnE9gG6xViAbFyqO7cGxFmBxUMw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <2d5c60f4-af72-8f68-f581-81ba376301e4@intel.com>
Date: Tue, 24 Oct 2017 12:11:25 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrz3ko-vhHR8Yj+i2JhnE9gG6xViAbFyqO7cGxFmBxUMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 24/10/17 10:39, Ulf Hansson wrote:
> [...]
> 
>>> However, you have completely ignored mine, Linus and Bartlomiej's
>>> comments about that we want the blkmq port being a separate patch(es)
>>> and then make the CMDQ patches on top. This worries me, because it
>>> seems like our messages don't reach you.
>>
>> Rubbish!  I gave a very good reason for keeping the CQE code in - it is
>> designed to work together.  I also pointed out that it is trivial to see the
>> CQE code and that it is all '+' lines anyway.
> 
> You gave reasons, but none of us bought them.
> 
>>
>> But not one question in response!  Where is a single example of why it is
>> difficult like it is.  Where are the questions!  Not even a request for
>> documentation!  How I am supposed to know what you do or don't understand if
>> you don't ask any questions! There is no evidence that you guys have read a
>> single line!
> 
> I have and I have also tested it, finding it not working. As reported.
> 
> However, I have also told you that I am having a *hard time* to review
> it, because it implements both blkmq and CMDQ in the same patch to
> code changes get complex.
> 
>>
>> So, what are your plans for the patches?  What don't you understand?
> 
> I have told you this several time, so has Linus and Bartlomiej.
> 
> If you can split it up such the blkmq support comes first, then I can
> review/test and pick it up.

I have done the split, but of course the code is just the same.
