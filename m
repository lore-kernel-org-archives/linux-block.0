Return-Path: <Himanshu.Madhani@cavium.com>
From: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 08/28] scsi: kill off the legacy IO path
Date: Thu, 25 Oct 2018 22:44:57 +0000
Message-ID: <00277AC6-781A-40FB-B9CB-D1E0CB3D0EC6@cavium.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-9-axboe@kernel.dk> <1540503399.66186.60.camel@acm.org>
 <30e6eb38-dda5-f4c1-c715-379864268147@kernel.dk>
In-Reply-To: <30e6eb38-dda5-f4c1-c715-379864268147@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Jens,=20

> On Oct 25, 2018, at 3:18 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> External Email
>=20
> On 10/25/18 3:36 PM, Bart Van Assche wrote:
>> On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
>>> @@ -3265,25 +3261,17 @@ qla2x00_probe_one(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>>>         base_vha->mgmt_svr_loop_id, host->sg_tablesize);
>>>=20
>>>     if (ha->mqenable) {
>>> -            bool mq =3D false;
>>>             bool startit =3D false;
>>>=20
>>> -            if (QLA_TGT_MODE_ENABLED()) {
>>> -                    mq =3D true;
>>> +            if (QLA_TGT_MODE_ENABLED())
>>>                     startit =3D false;
>>> -            }
>>>=20
>>> -            if ((ql2x_ini_mode =3D=3D QLA2XXX_INI_MODE_ENABLED) &&
>>> -                shost_use_blk_mq(host)) {
>>> -                    mq =3D true;
>>> +            if (ql2x_ini_mode =3D=3D QLA2XXX_INI_MODE_ENABLED)
>>>                     startit =3D true;
>>> -            }
>>>=20
>>> -            if (mq) {
>>> -                    /* Create start of day qpairs for Block MQ */
>>> -                    for (i =3D 0; i < ha->max_qpairs; i++)
>>> -                            qla2xxx_create_qpair(base_vha, 5, 0, start=
it);
>>> -            }
>>> +            /* Create start of day qpairs for Block MQ */
>>> +            for (i =3D 0; i < ha->max_qpairs; i++)
>>> +                    qla2xxx_create_qpair(base_vha, 5, 0, startit);
>>>     }
>>>=20
>>>     if (ha->flags.running_gold_fw)
>>=20
>> (+Himanshu)
>>=20
>> Since I'm not sure that "mq" in the above code refers to "scsi-mq" nor t=
hat it
>> refers to "blk-mq", I'm not sure the above changes should be included in=
 this
>> patch. Himanshu, can you have a look?
>=20
> There's literally a comment there that says "for Block MQ" :-)

This change is Good.

We were using mq boolean to determine if we are in Target mode or Initiator=
 with BLK-MQ on
to create qpair in firmware.

Since this patch is removing shost_use_blk_mq)(), so the mq boolean becomes=
 no-op.=20

>>> +static ssize_t
>>> +show_use_blk_mq(struct device *dev, struct device_attribute *attr, cha=
r *buf)
>>> +{
>>> +    return snprintf(buf, 20, "1\n");
>>> +}
>>> +static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
>>=20
>> The pattern "snprintf(buf, 20, ...)" looks like cargo-cult programming t=
o me.
>> Please consider changing "snprintf(buf, 20, " into "sprintf(buf, ".
>=20
> Good point, I'll do that.
>=20
> --
> Jens Axboe
>=20

Thanks,
- Himanshu
