Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C266411@IRSMSX106.ger.corp.intel.com>
References: <20180828154727.3589-1-ianwmorrison@gmail.com> <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk> <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk> <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
 <702eb090-2bf4-69d1-bfb6-afdca4ba5c5f@kernel.dk> <363DA0ED52042842948283D2FC38E4649C266411@IRSMSX106.ger.corp.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 29 Aug 2018 08:15:44 +0200
Message-ID: <CAPDyKFqLdWL-VG2uZsiQNrJA=VvytGJp0xYYd52jMtmeP1nLcw@mail.gmail.com>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To: "Hunter, Adrian" <adrian.hunter@intel.com>, Jens Axboe <axboe@kernel.dk>
Cc: Ian W MORRISON <ianwmorrison@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>, "loberman@redhat.com" <loberman@redhat.com>,
	"osandov@fb.com" <osandov@fb.com>, "hch@lst.de" <hch@lst.de>,
	"bart.vanassche@wdc.com" <bart.vanassche@wdc.com>, "hare@suse.de" <hare@suse.de>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 28 August 2018 at 21:11, Hunter, Adrian <adrian.hunter@intel.com> wrote:
>> -----Original Message-----
>> From: Jens Axboe [mailto:axboe@kernel.dk]
>> Sent: Tuesday, August 28, 2018 8:12 PM
>> To: Ian W MORRISON <ianwmorrison@gmail.com>
>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
>> kashyap.desai@broadcom.com; loberman@redhat.com; osandov@fb.com;
>> hch@lst.de; bart.vanassche@wdc.com; hare@suse.de;
>> ming.lei@redhat.com; Hunter, Adrian <adrian.hunter@intel.com>
>> Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
>> case of 'none'"
>>
>> On 8/28/18 11:01 AM, Ian W MORRISON wrote:
>> > On Wed, 29 Aug 2018 at 02:13, Jens Axboe <axboe@kernel.dk> wrote:
>> >>
>> >> On 8/28/18 10:10 AM, Ian W MORRISON wrote:
>> >>> On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
>> >>>>
>> >>>> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
>> >>>>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk>
>> wrote:
>> >>>>>>
>> >>>>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>> >>>>>>> Kernel oops when booting on Bay and Cherry Trail devices such as
>> >>>>>>> Intel Compute Stick. Bisected as:
>> >>>>>>>
>> >>>>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't
>> >>>>>>> busy in case of 'none'")
>> >>>>>>>
>> >>>>>>> This patch reverts the above commit.
>> >>>>>>
>> >>>>>> Did I miss the posting of that oops? Just curious where this is
>> >>>>>> going wrong. Not adverse to reverting, but I'd like to try to
>> >>>>>> understand the issue first.
>> >>>>>>
>> >>>>>> --
>> >>>>>> Jens Axboe
>> >>>>>>
>> >>>>>
>> >>>>> I've not been able to capture it however manually transcribing
>> >>>>> what is on the screen:
>> >>>>>
>> >>>>> mmc0: Got data interrupt 0x00000002 even though no data operation
>> >>>>>
>> >>>>> followed by:
>> >>>>>
>> >>>>> mmc0: sdhci: ============= SDHCI REGISTER DUMP
>> ==============
>> >>>>>
>> >>>>> Do you want any specific register value or should I transcribe
>> >>>>> each (as I am working from an image taken at boot)?
>> >>>>
>> >>>> Just take a picture of the screen, that should be good enough.
>> >>>>
>> >>>> --
>> >>>> Jens Axboe
>> >>>>
>> >>>
>> >>> Attached as requested.
>> >>
>> >> Can you see if this patch helps?
>> >>
>> >> https://marc.info/?l=linux-mmc&m=153485326025301&w=2
>> >>
>> >> --
>> >> Jens Axboe
>> >>
>> >
>> > I confirm that the above patch works with commit 6ce3dd6eec11 and
>> > removes the need for reverting it on eMMC based devices.
>> >
>> > Tested on Bay Trail, Cherry Trail (both now working) and Kaby Lake
>> > (not affected) devices.
>>
>> Great, thanks for testing. Adrian, when is this going upstream?
>
> It is in Ulf's fixes branch, so most likely v4.19-rc2 .  Then to stable in due course.
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=fixes&id=26caddf274cf1e89fd4ce44ab2b8dbc7a7f97681

Yep, correct!

As I told someone before, I am deliberately holding on to fixes a
little longer that before, to extend the test coverage a bit.

If someone wants to test the latest rc with fixes, one could instead
try the pending-fixes branch in Stephen Rothwell's linux-next tree.

Kind regards
Uffe
