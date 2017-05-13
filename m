Return-Path: <sedat.dilek@gmail.com>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUXNbdjLwsSTnGQPdhKe1RVkMF1D1yEOVhx2LZ+kswFOVA@mail.gmail.com>
References: <CA+icZUV8wEKJkDpfMaPhAyc1fyVG-ViZF4nO=5raZOkLa_ikzQ@mail.gmail.com>
 <20170502080044.GA292@x4> <CA+icZUXVtBnDZd--nB8xZx0wQAiPAHp9QWhCxo2t62Q0SCui5Q@mail.gmail.com>
 <20170502121605.GA294@x4> <CA+icZUUJor+TK18ac8CepUd26ehcTijaA7NAmQxqW4b8yGJpzg@mail.gmail.com>
 <20170503091628.GB292@x4> <886609A4-9996-410F-8BB4-65B23866B31D@linaro.org> <CA+icZUXNbdjLwsSTnGQPdhKe1RVkMF1D1yEOVhx2LZ+kswFOVA@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 13 May 2017 10:00:19 +0200
Message-ID: <CA+icZUV2a40mRGCbCVQvtQLVe=C7K7w9uTbWjQ6mOLUN1xgcvg@mail.gmail.com>
Subject: Re: Playing with BFQ
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Content-Type: multipart/mixed; boundary="001a11467a5e9af500054f63366f"
List-ID: <linux-block@vger.kernel.org>

--001a11467a5e9af500054f63366f
Content-Type: text/plain; charset="UTF-8"

On Sat, May 13, 2017 at 9:54 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Wed, May 3, 2017 at 11:24 AM, Paolo Valente <paolo.valente@linaro.org> wrote:
>>
>>> Il giorno 03 mag 2017, alle ore 11:16, Markus Trippelsdorf <markus@trippelsdorf.de> ha scritto:
>>>
>>> On 2017.05.03 at 10:00 +0200, Sedat Dilek wrote:
>>>> On Tue, May 2, 2017 at 2:16 PM, Markus Trippelsdorf
>>>> <markus@trippelsdorf.de> wrote:
>>>>> On 2017.05.02 at 14:07 +0200, Sedat Dilek wrote:
>>>>>> On Tue, May 2, 2017 at 10:00 AM, Markus Trippelsdorf
>>>>>> <markus@trippelsdorf.de> wrote:
>>>>>>> On 2017.05.02 at 09:54 +0200, Sedat Dilek wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I want to play with BFQ.
>>>>>>>>
>>>>>>>> My base is block-next as of 28-Apr-2017.
>>>>>> [...]
>>>>>>>> Not sure if the attached patches make sense (right now).
>>>>>>>
>>>>>>> No, it doesn't make sense at all.
>>>>>>
>>>>>> Hmm, I looked at 4.11.0-v8r11 and 0001 has exactly what my 2 patches do :-).
>>>>>
>>>>> BFQ started as a conventional scheduler. But because mq is the way of
>>>>> the future it was ported before it was accepted into mainline.
>>>>>
>>>>
>>>> I am still playing and want to do my own experiences with BFQ.
>>>>
>>>> Not sure if FIO is a good testcase-tool here.
>>>>
>>>> So if MQ is the way why isn't the Kconfig called CONFIG_MQ_IOSCHED_BFQ
>>>> according to CONFIG_MQ_IOSCHED_DEADLINE?
>>>
>>> Good point. The current naming is confusing.
>>>
>>> Also:
>>> # cat /sys/block/sda/queue/scheduler
>>> mq-deadline [kyber] bfq none
>>>
>>> These should all be prefixed with mq-.
>>>
>>
>> The logic here, as proposed by Jens, is not to add the mq tag when
>> there is no risk of ambiguity (such as between deadline and
>> mq-deadline). I'm open to any sensible choice.
>>
>
> The naming is confusing but I can understand the point of Jens.
>
> The Kconfigs of BFQ in block/Kconfig.iosched need a move (see my two
> patches attached in the initial posting).
> AFAICS you have the same in your latest BFQ-patchset for Linux v4.11.y.
>
> I am re-attaching my two patches.
>
> - Sedat -

Updated 0002 patch v2.

- Sedat -

--001a11467a5e9af500054f63366f
Content-Type: text/x-patch; charset="US-ASCII";
	name="0002-block-bfq-Introduce-CONFIG_DEFAULT_BFQ.patch"
Content-Disposition: attachment;
	filename="0002-block-bfq-Introduce-CONFIG_DEFAULT_BFQ.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j2mzdupx2

RnJvbSBkYTMzNzk0MjRmYzAyMzdkNWRlMjVlOTQ2ZWQ1NDgyYTYyNWFhYWMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDIgTWF5IDIwMTcgMDk6MzM6MjcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBibG9j
azogYmZxOiBJbnRyb2R1Y2UgQ09ORklHX0RFRkFVTFRfQkZRCgotLS0KWyB2Mjogcy9ERUZBVUxU
X0JGUS9DT05GSUdfREVGQVVMVF9CRlEgaW4gc3ViamVjdCBsaW5lLiAtZGlsZWtzIF0KCiBibG9j
ay9LY29uZmlnLmlvc2NoZWQgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9ibG9jay9LY29uZmlnLmlvc2NoZWQgYi9ibG9jay9LY29uZmlnLmlv
c2NoZWQKaW5kZXggOGVhMmM4ZDc3MTAwLi5mMzc0NTVkY2YzODEgMTAwNjQ0Ci0tLSBhL2Jsb2Nr
L0tjb25maWcuaW9zY2hlZAorKysgYi9ibG9jay9LY29uZmlnLmlvc2NoZWQKQEAgLTczLDYgKzcz
LDkgQEAgY2hvaWNlCiAJY29uZmlnIERFRkFVTFRfQ0ZRCiAJCWJvb2wgIkNGUSIgaWYgSU9TQ0hF
RF9DRlE9eQogCisJY29uZmlnIERFRkFVTFRfQkZRCisJCWJvb2wgIkJGUSIgaWYgSU9TQ0hFRF9C
RlE9eQorCiAJY29uZmlnIERFRkFVTFRfTk9PUAogCQlib29sICJOby1vcCIKIApAQCAtODIsNiAr
ODUsNyBAQCBjb25maWcgREVGQVVMVF9JT1NDSEVECiAJc3RyaW5nCiAJZGVmYXVsdCAiZGVhZGxp
bmUiIGlmIERFRkFVTFRfREVBRExJTkUKIAlkZWZhdWx0ICJjZnEiIGlmIERFRkFVTFRfQ0ZRCisJ
ZGVmYXVsdCAiYmZxIiBpZiBERUZBVUxUX0JGUQogCWRlZmF1bHQgIm5vb3AiIGlmIERFRkFVTFRf
Tk9PUAogCiBjb25maWcgTVFfSU9TQ0hFRF9ERUFETElORQotLSAKMi4xMS4wCgo=
--001a11467a5e9af500054f63366f--
